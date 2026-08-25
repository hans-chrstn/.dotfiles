#!/usr/bin/env python3
"""Reject candidate edits that mix explicit and implicit Nix module styles."""

from __future__ import annotations

import re
import subprocess
import sys
from pathlib import Path

ASSIGNMENT = re.compile(r"^\s*([A-Za-z_][\w'-]*(?:\.[\w'-]+)*)\s*=")


def brace_depths(source: str) -> list[int]:
    """Return brace depth at each line start, ignoring comments and strings."""
    depths: list[int] = []
    depth = 0
    in_string = False
    in_indented_string = False
    escaped = False

    for line in source.splitlines():
        depths.append(depth)
        index = 0
        while index < len(line):
            pair = line[index : index + 2]
            char = line[index]

            if in_indented_string:
                if pair == "''":
                    in_indented_string = False
                    index += 2
                    continue
                index += 1
                continue

            if in_string:
                if escaped:
                    escaped = False
                elif char == "\\":
                    escaped = True
                elif char == '"':
                    in_string = False
                index += 1
                continue

            if pair == "''":
                in_indented_string = True
                index += 2
                continue
            if char == '"':
                in_string = True
                index += 1
                continue
            if char == "#":
                break
            if char == "{":
                depth += 1
            elif char == "}":
                depth -= 1
            index += 1

    return depths


def added_lines(path: str) -> set[int]:
    diff = subprocess.run(
        ["git", "diff", "--unified=0", "--", path],
        check=True,
        capture_output=True,
        text=True,
    ).stdout
    result: set[int] = set()
    new_line = 0
    for line in diff.splitlines():
        if line.startswith("@@"):
            match = re.search(r"\+(\d+)", line)
            if match:
                new_line = int(match.group(1))
            continue
        if line.startswith("+") and not line.startswith("+++"):
            result.add(new_line)
            new_line += 1
        elif not line.startswith("-"):
            new_line += 1
    return result


def violations(path: Path) -> list[str]:
    lines = path.read_text(errors="replace").splitlines()
    depths = brace_depths(path.read_text(errors="replace"))
    assignments = [
        (number, depths[number - 1], match.group(1))
        for number, line in enumerate(lines, start=1)
        if (match := ASSIGNMENT.match(line))
    ]
    explicit_depths = {
        depth
        for _, depth, name in assignments
        if name == "config" or name == "options" or name.startswith("options.")
    }
    if not explicit_depths:
        return []

    added = added_lines(str(path))
    allowed = {"config", "options", "imports", "meta", "_module", "disabledModules"}
    return [
        f"{path}:{number}: top-level assignment '{name}' mixes implicit configuration with explicit config/options"
        for number, depth, name in assignments
        if number in added
        and depth in explicit_depths
        and name.split(".", 1)[0] not in allowed
    ]


def main(paths: list[str]) -> int:
    errors = [error for path in paths for error in violations(Path(path))]
    if errors:
        print("Invalid Nix module structure:", file=sys.stderr)
        print("\n".join(errors), file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
