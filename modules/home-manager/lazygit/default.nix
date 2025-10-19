{ lib, config, ... }:
let
 cfg = config.mod.programs.lazygit;
in
{
  options.mod.programs.lazygit = {
    enable = lib.mkEnableOption "Enable Emeet lazygit config and it's best values";
  };

  config = lib.mkIf cfg.enable {
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
