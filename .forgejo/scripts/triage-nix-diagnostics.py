#!/usr/bin/env python3
"""Select one grounded Nix diagnostic and repository-local candidate files."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
from pathlib import Path

ASSIGNMENT = re.compile(
    r"^\s*([A-Za-z_][\w'-]*(?:\.[\w'-]+)+)\s*=\s*([^;\n]+);",
    re.MULTILINE,
)
OPTION = re.compile(r"option [`']([^`']+)[`']")
WARNING_START = re.compile(r"(?m)^(?:evaluation )?warning:")
ANSI_ESCAPE = re.compile(r"\x1b(?:\[[0-?]*[ -/]*[@-~]|[@-_])")
CONTROL_CHARACTER = re.compile(r"[\x00-\x08\x0b\x0c\x0e-\x1f\x7f]")
INSTRUCTION_LINE = re.compile(
    r"(?im)^.*(?:ignore (?:all )?(?:previous|above) instructions|"
    r"(?:system|developer|assistant) prompt:).*(?:\n|$)"
)
STORE_PATH = re.compile(r"/nix/store/[a-z0-9]{32}-[^\s'`]+")
PROTECTED = re.compile(
    r"(^|/)(?:secrets|credentials|\.forgejo/workflows)(?:/|$)"
    r"|(?:^|/)(?:\.env|\.sops\.yaml|id_rsa)$"
    r"|\.(?:age|key|pem)$|^flake\.lock$"
)


def git_matches(repo: Path, expression: str) -> list[str]:
    result = subprocess.run(
        [
            "git",
            "grep",
            "--files-with-matches",
            "--extended-regexp",
            expression,
            "--",
            "*.nix",
        ],
        cwd=repo,
        check=False,
        capture_output=True,
        text=True,
    )
    return [
        line
        for line in result.stdout.splitlines()
        if line and not PROTECTED.search(line)
    ]


def candidate_rank(repo: Path, path: str, expression: str) -> tuple[int, str]:
    """Prefer configuration assignments over option declarations."""
    matcher = re.compile(expression.replace("[[:space:]]", r"\s"))
    configuration_match = False
    declaration_match = False
    for line in (repo / path).read_text(errors="replace").splitlines():
        if not matcher.search(line):
            continue
        if re.match(r"^\s*options(?:\.|\s*=)", line):
            declaration_match = True
        else:
            configuration_match = True

    if configuration_match:
        return (0, path)
    if declaration_match:
        return (2, path)
    return (1, path)


def candidates_for_option(repo: Path, option: str) -> tuple[list[str], str | None]:
    components = option.split(".")
    expressions = [re.escape(option)]

    # Search progressively broader owning option sets. This turns an emitted
    # leaf such as programs.neovim.withRuby into programs.neovim = without
    # encoding any particular NixOS or Home Manager option in this script.
    for length in range(len(components) - 1, 1, -1):
        parent = ".".join(components[:length])
        expressions.append(rf"{re.escape(parent)}[[:space:]]*=")

    matches: list[str] = []
    for expression in expressions:
        expression_matches = sorted(
            git_matches(repo, expression),
            key=lambda path: candidate_rank(repo, path, expression),
        )
        for path in expression_matches:
            if path not in matches:
                matches.append(path)
        if matches:
            return matches, expression
    return [], None


def sanitize_diagnostics(diagnostics: str) -> str:
    diagnostics = ANSI_ESCAPE.sub("", diagnostics)
    diagnostics = CONTROL_CHARACTER.sub("", diagnostics)
    return INSTRUCTION_LINE.sub("", diagnostics)


def diagnostic_fingerprint(kind: str, target: str, diagnostic: str) -> str:
    normalized = STORE_PATH.sub("/nix/store/[STORE-PATH]", diagnostic)
    normalized = re.sub(
        r"(?im)^((?:evaluation )?warning:)\s+[^:\n]+ profile:",
        r"\1 profile:",
        normalized,
    )
    normalized = re.sub(r"\s+", " ", normalized).strip().lower()
    material = f"{kind}\n{target}\n{normalized}".encode()
    return hashlib.sha256(material).hexdigest()[:20]


def external_inputs(repo: Path, diagnostic: str) -> list[dict[str, object]]:
    lock_path = repo / "flake.lock"
    if not lock_path.exists():
        return []

    lock = json.loads(lock_path.read_text())
    lowered = diagnostic.lower()
    matches: dict[str, dict[str, object]] = {}
    root_inputs = lock.get("nodes", {}).get("root", {}).get("inputs", {})

    for input_name, node_reference in root_inputs.items():
        node_name = (
            node_reference[0] if isinstance(node_reference, list) else node_reference
        )
        node = lock.get("nodes", {}).get(node_name, {})
        locked = node.get("locked", {})
        repo_name = str(locked.get("repo", ""))
        identifiers = {
            input_name.lower().lstrip("."),
            str(node_name).lower().lstrip("."),
            repo_name.lower().lstrip("."),
        }
        identifiers.discard("")

        if not any(
            len(identifier) >= 4 and identifier in lowered for identifier in identifiers
        ):
            continue

        node_key = str(node_name)
        if node_key not in matches:
            matches[node_key] = {
                "inputs": [],
                "node": node_key,
                "type": str(locked.get("type", "unknown")),
                "owner": str(locked.get("owner", "")),
                "repo": repo_name,
                "rev": str(locked.get("rev", "")),
            }
        inputs = matches[node_key]["inputs"]
        if isinstance(inputs, list) and input_name not in inputs:
            inputs.append(input_name)
    return list(matches.values())[:5]


def candidate_evidence(repo: Path, candidates: list[str], target: str) -> list[dict]:
    components = target.split(".")
    terms = [target]
    if len(components) > 1:
        terms.append(".".join(components[:-1]))
    terms.append(components[-1])

    evidence: list[dict] = []
    for candidate in candidates:
        lines = (repo / candidate).read_text(errors="replace").splitlines()
        matching_line = next(
            (
                index
                for index, line in enumerate(lines)
                if any(term in line for term in terms)
            ),
            None,
        )
        if matching_line is None:
            continue

        start = max(0, matching_line - 4)
        end = min(len(lines), matching_line + 5)
        evidence.append(
            {
                "path": candidate,
                "start_line": start + 1,
                "excerpt": "\n".join(
                    f"{line_number + 1}: {lines[line_number]}"
                    for line_number in range(start, end)
                ),
            }
        )
    return evidence


def warning_blocks(diagnostics: str) -> list[str]:
    starts = [match.start() for match in WARNING_START.finditer(diagnostics)]
    blocks: list[str] = []
    for index, start in enumerate(starts):
        end = starts[index + 1] if index + 1 < len(starts) else len(diagnostics)
        blocks.append(diagnostics[start:end].strip()[:4000])
    return blocks


def select_warning(
    repo: Path,
    diagnostics: str,
    policy: dict[str, object],
) -> dict[str, object] | None:
    for block in warning_blocks(diagnostics):
        suppression_phrases = policy.get("suppressionPhrases", [])
        if any(str(phrase).lower() in block.lower() for phrase in suppression_phrases):
            continue

        for match in ASSIGNMENT.finditer(block):
            option, value = match.groups()
            candidates, search_expression = candidates_for_option(repo, option)
            if candidates:
                selection: dict[str, object] = {
                    "kind": "warning",
                    "target": option,
                    "suggested_value": value.strip(),
                    "diagnostic": block,
                    "candidates": candidates[: int(policy.get("maxCandidateFiles", 3))],
                    "candidate_search": search_expression,
                }
                selection["candidate_evidence"] = candidate_evidence(
                    repo, selection["candidates"], option
                )
                selection["fingerprint"] = diagnostic_fingerprint(
                    "warning", option, block
                )
                return selection
    return None


def select_failure(
    repo: Path,
    diagnostics: str,
    policy: dict[str, object],
) -> dict[str, object] | None:
    candidates: list[str] = []
    tracked = subprocess.run(
        ["git", "ls-files", "*.nix"],
        cwd=repo,
        check=True,
        capture_output=True,
        text=True,
    ).stdout.splitlines()

    for path in tracked:
        if path in diagnostics and not PROTECTED.search(path):
            candidates.append(path)

    for option in OPTION.findall(diagnostics):
        option_candidates, _ = candidates_for_option(repo, option)
        for path in option_candidates:
            if path not in candidates:
                candidates.append(path)

    if not candidates or "error:" not in diagnostics.lower():
        return None

    error_position = diagnostics.lower().rfind("error:")
    excerpt_start = max(0, error_position - 1200)
    excerpt_end = min(len(diagnostics), error_position + 2800)
    diagnostic = diagnostics[excerpt_start:excerpt_end]
    selection: dict[str, object] = {
        "kind": "failure",
        "target": "root cause of selected Nix failure",
        "suggested_value": None,
        "diagnostic": diagnostic,
        "candidates": candidates[: int(policy.get("maxCandidateFiles", 3))],
        "candidate_search": "repository paths and evaluated option names in trace",
    }
    selection["fingerprint"] = diagnostic_fingerprint(
        "failure", str(selection["target"]), diagnostic
    )
    return selection


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("diagnostics", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--repo", type=Path, default=Path.cwd())
    parser.add_argument(
        "--policy",
        type=Path,
        default=Path(".forgejo/remediation-policy.json"),
    )
    args = parser.parse_args()

    diagnostics = sanitize_diagnostics(args.diagnostics.read_text(errors="replace"))
    policy = json.loads((args.repo / args.policy).read_text())
    selection = select_warning(args.repo, diagnostics, policy)
    if selection is None:
        selection = select_failure(args.repo, diagnostics, policy)

    if selection is None:
        owners = external_inputs(args.repo, diagnostics)
        reason = "No repository-owned candidate was found."
        if owners:
            reason += " The diagnostic appears to belong to an external flake input."
        result: dict[str, object] = {
            "status": "skipped",
            "reason": reason,
            "external_inputs": owners,
            "fingerprint": diagnostic_fingerprint("skipped", "external", diagnostics),
        }
    else:
        result = {"status": "ready", **selection}

    args.output.write_text(json.dumps(result, indent=2) + "\n")


if __name__ == "__main__":
    main()
