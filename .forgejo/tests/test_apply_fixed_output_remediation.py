from __future__ import annotations

import json
import subprocess
import tempfile
import unittest
from pathlib import Path

SCRIPT = Path(__file__).parents[1] / "scripts" / "apply-fixed-output-remediation.py"


class FixedOutputRemediationTests(unittest.TestCase):
    def test_replaces_exactly_one_grounded_hash(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            repo = Path(directory)
            source = repo / "source.nix"
            source.write_text('sha256 = "old-hash";\n')
            selection = repo / "selection.json"
            selection.write_text(
                json.dumps(
                    {
                        "classification": "fixed-output-hash",
                        "target": "old-hash",
                        "suggested_value": "new-hash",
                        "candidates": ["source.nix"],
                    }
                )
            )

            subprocess.run(
                ["python3", str(SCRIPT), str(selection), "--repo", str(repo)],
                check=True,
            )

            self.assertEqual(source.read_text(), 'sha256 = "new-hash";\n')

    def test_rejects_ambiguous_replacements(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            repo = Path(directory)
            source = repo / "source.nix"
            source.write_text('first = "old-hash"; second = "old-hash";\n')
            selection = repo / "selection.json"
            selection.write_text(
                json.dumps(
                    {
                        "classification": "fixed-output-hash",
                        "target": "old-hash",
                        "suggested_value": "new-hash",
                        "candidates": ["source.nix"],
                    }
                )
            )

            result = subprocess.run(
                ["python3", str(SCRIPT), str(selection), "--repo", str(repo)],
                check=False,
                capture_output=True,
                text=True,
            )

            self.assertNotEqual(result.returncode, 0)
            self.assertEqual(
                source.read_text(), 'first = "old-hash"; second = "old-hash";\n'
            )


if __name__ == "__main__":
    unittest.main()
