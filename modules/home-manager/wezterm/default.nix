{
  lib,
  config,
  ...
}: let
  cfg = config.mod.programs.wezterm;
in {
  options.mod.programs.wezterm = {
    enable = lib.mkEnableOption "Enable the wezterm feature";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile = {
      "wezterm/wezterm.lua" = {
        enable = true;
      };
    };

    programs.wezterm = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
