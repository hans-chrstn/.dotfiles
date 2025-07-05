{ lib, config, ... }:
with lib;
let
 cfg = config.mod.fuzzel;
in
{
  options.mod.fuzzel = {
    enable = mkEnableOption "Enable fuzzel config and it's best values";
    enableCatppuccinMocha = mkEnableOption "Enable Catppuccin Mocha Theme";
  };

  config = mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;
      settings = mkIf cfg.enableCatppuccinMocha {
        colors = {
          background = "1e1e2eff";
          text = "cdd6f4ff";
          match = "f38ba8ff";
          selection = "585b70ff";
          selection-match = "f38ba8ff";
          selection-text = "cdd6f4ff";
          border = "b4befeff";
        };
        border = {};
        dmenu = {};
        key-bindings = {};
      };
    };
  };
}
