from __future__ import annotations

import importlib.util
import tempfile
import unittest
from pathlib import Path

SCRIPT = Path(__file__).parents[1] / "scripts" / "apply-nix-option-remediation.py"
SPEC = importlib.util.spec_from_file_location("option_remediation", SCRIPT)
assert SPEC and SPEC.loader
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class OptionRemediationTests(unittest.TestCase):
    def apply(self, source: str, target: str, value: str) -> tuple[bool, str]:
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "module.nix"
            path.write_text(source)
            changed = MODULE.apply_option(path, target, value)
            return changed, path.read_text()

    def test_places_leaf_in_longest_existing_parent(self) -> None:
        changed, result = self.apply(
            """{
  options.example.enable = true;
  config = {
    programs.neovim = {
      enable = true;
    };
  };
}
""",
            "programs.neovim.withRuby",
            "true",
        )
        self.assertTrue(changed)
        self.assertIn("      withRuby = true;\n    };", result)
        self.assertNotIn("\n  programs.neovim.withRuby", result)

    def test_builds_remaining_suffix_under_broader_parent(self) -> None:
        changed, result = self.apply(
            """{
  config = {
    gtk = {
      enable = true;
    };
  };
}
""",
            "gtk.gtk4.theme",
            "null",
        )
        self.assertTrue(changed)
        self.assertIn("      gtk4.theme = null;", result)

    def test_does_not_duplicate_existing_assignment(self) -> None:
        source = "{ programs.neovim.withRuby = true; }\n"
        changed, result = self.apply(source, "programs.neovim.withRuby", "true")
        self.assertFalse(changed)
        self.assertEqual(source, result)

    def test_returns_false_without_an_existing_parent_attrset(self) -> None:
        changed, _ = self.apply("{ services.example.enable = true; }\n", "gtk.gtk4.theme", "null")
        self.assertFalse(changed)

    def test_places_option_inside_mkif_parent(self) -> None:
        changed, result = self.apply(
            """{
  config = {
    programs.editor = lib.mkIf enabled {
      enable = true;
    };
  };
}
""",
            "programs.editor.package",
            "pkgs.neovim",
        )
        self.assertTrue(changed)
        self.assertIn("      package = pkgs.neovim;", result)

    def test_ignores_braces_inside_indented_strings(self) -> None:
        changed, result = self.apply(
            """{
  config = {
    programs.editor = {
      extraConfig = ''literal { brace }'';
    };
  };
}
""",
            "programs.editor.enable",
            "true",
        )
        self.assertTrue(changed)
        self.assertIn("      enable = true;", result)


if __name__ == "__main__":
    unittest.main()
