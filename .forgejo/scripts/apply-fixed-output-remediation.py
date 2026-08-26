#!/usr/bin/env python3
"""Apply one exact, repository-grounded fixed-output hash correction."""

from __future__ import annotations

import argparse
import json
from pathlib import Path


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("selection", type=Path)
    parser.add_argument("--repo", type=Path, default=Path.cwd())
    args = parser.parse_args()

    repo = args.repo.resolve()
    selection = json.loads(args.selection.read_text())
    if selection.get("classification") != "fixed-output-hash":
        return 2

    old = selection["target"]
    new = selection["suggested_value"]
    matches: list[tuple[Path, str, int]] = []
    for relative in selection.get("candidates", []):
        path = (repo / relative).resolve()
        path.relative_to(repo)
        content = path.read_text()
        count = content.count(old)
        if count:
            matches.append((path, content, count))

    replacements = sum(count for _, _, count in matches)
    if replacements != 1:
        raise SystemExit(
            f"expected exactly one grounded hash occurrence, found {replacements}"
        )
    path, content, _ = matches[0]
    path.write_text(content.replace(old, new))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
