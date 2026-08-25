from __future__ import annotations

import importlib.util
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

SCRIPT = Path(__file__).parents[1] / "scripts" / "check-nix-module-shape.py"
SPEC = importlib.util.spec_from_file_location("module_shape", SCRIPT)
assert SPEC and SPEC.loader
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class ModuleShapeTests(unittest.TestCase):
    def check(self, source: str, added: set[int]) -> list[str]:
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "module.nix"
            path.write_text(source)
            with patch.object(MODULE, "added_lines", return_value=added):
                return MODULE.violations(path)

    def test_rejects_added_implicit_assignment_beside_explicit_config(self) -> None:
        source = """{
  options.example.enable = true;
  config = { services.example.enable = true; };
  programs.neovim.withRuby = true;
}
"""
        self.assertEqual(len(self.check(source, {4})), 1)

    def test_accepts_assignment_inside_explicit_config(self) -> None:
        source = """{
  options.example.enable = true;
  config = {
    programs.neovim.withRuby = true;
  };
}
"""
        self.assertEqual(self.check(source, {4}), [])

    def test_accepts_implicit_module_style(self) -> None:
        source = """{
  programs.neovim.withRuby = true;
}
"""
        self.assertEqual(self.check(source, {2}), [])


if __name__ == "__main__":
    unittest.main()
