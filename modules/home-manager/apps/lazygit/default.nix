{ lib, config, ... }:
with lib;
let
 cfg = config.mod.lazygit;
in
{
  options.mod.lazygit = {
    enable = mkEnableOption "Enable Emeet lazygit config and it's best values";
  };

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        nerdFontsVersion = 3;
        border = "rounded";
        keybinding.universal = {
          pullFiles = "<c-p>";
        };
      };
    };
  };
}
