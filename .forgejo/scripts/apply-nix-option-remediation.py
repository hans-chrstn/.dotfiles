#!/usr/bin/env python3
"""Apply a diagnostic-provided Nix option beneath an existing parent attrset."""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path


def closing_brace(source: str, opening: int) -> int | None:
    depth = 0
    in_string = False
    in_indented_string = False
    escaped = False
    index = opening
    while index < len(source):
        pair = source[index : index + 2]
        char = source[index]
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
            newline = source.find("\n", index)
            index = len(source) if newline == -1 else newline + 1
            continue
        if char == "{":
            depth += 1
        elif char == "}":
            depth -= 1
            if depth == 0:
                return index
        index += 1
    return None


def apply_option(path: Path, target: str, value: str) -> bool:
    source = path.read_text()
    if re.search(rf"(?m)^\s*{re.escape(target)}\s*=", source):
        return False

    components = target.split(".")
    for length in range(len(components) - 1, 0, -1):
        parent = ".".join(components[:length])
        pattern = re.compile(rf"(?m)^(?P<indent>\s*){re.escape(parent)}\s*=\s*(?P<rhs>[^\n]*)")
        for match in pattern.finditer(source):
            opening = source.find("{", match.start("rhs"), match.end("rhs"))
            if opening == -1:
                continue
            closing = closing_brace(source, opening)
            if closing is None:
                continue
            line_start = source.rfind("\n", 0, closing) + 1
            closing_indent = re.match(r"\s*", source[line_start:closing]).group(0)
            suffix = ".".join(components[length:])
            insertion = f"{closing_indent}  {suffix} = {value};\n"
            source = source[:line_start] + insertion + source[line_start:]
            path.write_text(source)
            return True
    return False


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("selection", type=Path)
    args = parser.parse_args()
    selection = json.loads(args.selection.read_text())
    if selection.get("kind") != "warning" or selection.get("suggested_value") is None:
        return 1
    for candidate in selection.get("candidates", []):
        if apply_option(
            Path(candidate),
            str(selection["target"]),
            str(selection["suggested_value"]),
        ):
            print(f"Applied {selection['target']} beneath an existing parent in {candidate}")
            return 0
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
