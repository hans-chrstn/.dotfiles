#!/usr/bin/env python3
"""Select one grounded Nix diagnostic and repository-local candidate files."""

from __future__ import annotations

import argparse
import base64
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
FIXED_OUTPUT_MISMATCH = re.compile(
    r"hash mismatch in fixed-output derivation.*?"
    r"specified:\s*(?P<specified>sha256-[A-Za-z0-9+/=]+).*?"
    r"got:\s*(?P<got>sha256-[A-Za-z0-9+/=]+)",
    re.DOTALL,
)
NIX_BASE32 = "0123456789abcdfghijklmnpqrsvwxyz"
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
INFRASTRUCTURE_FAILURE = re.compile(
    r"(?i)(?:could not resolve host|connection (?:refused|reset|timed out)|"
    r"gateway timeout|temporary failure in name resolution|no space left on device|"
    r"cannot allocate memory|substituter.*failed|failed to connect|"
    r"attic.*(?:error|failed|timeout)|http (?:499|502|503|504))"
)


def failure_classification(diagnostic: str) -> str:
    lowered = diagnostic.lower()
    if FIXED_OUTPUT_MISMATCH.search(diagnostic):
        return "fixed-output-hash"
    if INFRASTRUCTURE_FAILURE.search(diagnostic):
        return "infrastructure"
    if "does not exist" in lowered or "undefined variable" in lowered:
        return "missing-attribute"
    if "unsupported attribute" in lowered or "module" in lowered and "config" in lowered:
        return "module-structure"
    if "is not of type" in lowered or "type error" in lowered:
        return "type-mismatch"
    if "failed assertions" in lowered or "assertion" in lowered:
        return "assertion"
    if "cannot build" in lowered or "builder for" in lowered:
        return "build"
    return "evaluation"


def sri_to_nix_base32(value: str) -> str:
    raw = base64.b64decode(value.removeprefix("sha256-"), validate=True)
    output = []
    for n in range((len(raw) * 8 - 1) // 5, -1, -1):
        bit = n * 5
        index = bit // 8
        digit = raw[index] >> (bit % 8)
        if index + 1 < len(raw):
            digit |= raw[index + 1] << (8 - bit % 8)
        output.append(NIX_BASE32[digit & 0x1F])
    return "".join(output)


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


def policy_fallback_candidates(
    repo: Path,
    policy: dict[str, object],
    scope: str,
) -> list[str]:
    configured = policy.get("fallbackCandidates", {})
    if not isinstance(configured, dict):
        return []
    paths = configured.get(scope, [])
    if not isinstance(paths, list):
        return []

    candidates = []
    for value in paths:
        path = str(value)
        if PROTECTED.search(path) or not (repo / path).is_file():
            continue
        tracked = subprocess.run(
            ["git", "ls-files", "--error-unmatch", "--", path],
            cwd=repo,
            check=False,
            capture_output=True,
            text=True,
        )
        if tracked.returncode == 0:
            candidates.append(path)
    return candidates


def is_home_manager_warning(block: str) -> bool:
    return bool(
        re.search(r"(?im)^(?:evaluation )?warning:\s+[^:\n]+ profile:", block)
        or "home.stateVersion" in block
        or "Home Manager" in block
    )


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
            if not candidates and is_home_manager_warning(block):
                candidates = policy_fallback_candidates(
                    repo, policy, "home-manager"
                )
                if candidates:
                    search_expression = "policy-controlled Home Manager compatibility module"
            if candidates:
                selection: dict[str, object] = {
                    "kind": "warning",
                    "classification": "option-warning",
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

    classification = failure_classification(diagnostics)
    if classification == "infrastructure":
        return None
    if not candidates or "error:" not in diagnostics.lower():
        return None

    error_position = diagnostics.lower().rfind("error:")
    excerpt_start = max(0, error_position - 1200)
    excerpt_end = min(len(diagnostics), error_position + 2800)
    diagnostic = diagnostics[excerpt_start:excerpt_end]
    selection: dict[str, object] = {
        "kind": "failure",
        "classification": classification,
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


def select_fixed_output_failure(
    repo: Path,
    diagnostics: str,
    policy: dict[str, object],
) -> dict[str, object] | None:
    match = FIXED_OUTPUT_MISMATCH.search(diagnostics)
    if not match:
        return None

    specified_sri = match.group("specified")
    got_sri = match.group("got")
    encodings = (
        (specified_sri, got_sri),
        (sri_to_nix_base32(specified_sri), sri_to_nix_base32(got_sri)),
    )
    candidates: list[str] = []
    selected_old = None
    selected_new = None
    for old_value, new_value in encodings:
        for path in git_matches(repo, re.escape(old_value)):
            if path not in candidates:
                candidates.append(path)
            selected_old = old_value
            selected_new = new_value

    if not candidates or selected_old is None or selected_new is None:
        return None

    excerpt_start = max(0, match.start() - 300)
    excerpt_end = min(len(diagnostics), match.end() + 300)
    diagnostic = diagnostics[excerpt_start:excerpt_end]
    selection: dict[str, object] = {
        "kind": "failure",
        "classification": "fixed-output-hash",
        "target": selected_old,
        "suggested_value": selected_new,
        "diagnostic": diagnostic,
        "candidates": candidates[: int(policy.get("maxCandidateFiles", 3))],
        "candidate_search": "exact stale fixed-output hash in repository sources",
    }
    selection["candidate_evidence"] = candidate_evidence(
        repo, selection["candidates"], selected_old
    )
    selection["fingerprint"] = diagnostic_fingerprint(
        "failure", selected_old, diagnostic
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
    classification = failure_classification(diagnostics)
    infrastructure = classification == "infrastructure"
    validation_state = re.search(
        r"(?m)^validation_failed=(true|false)\s*$", diagnostics
    )
    validation_failed = (
        validation_state.group(1) == "true"
        if validation_state
        else "error:" in diagnostics.lower()
    )
    selection = None
    if not infrastructure and validation_failed:
        selection = select_fixed_output_failure(args.repo, diagnostics, policy)
        if selection is None:
            selection = select_failure(args.repo, diagnostics, policy)
    if selection is None and not infrastructure and not validation_failed:
        selection = select_warning(args.repo, diagnostics, policy)

    if selection is None:
        owners = external_inputs(args.repo, diagnostics)
        reason = (
            "Infrastructure failure detected; automated source remediation is not appropriate."
            if infrastructure
            else "No repository-owned candidate was found."
        )
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
