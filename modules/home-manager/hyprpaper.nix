{ lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.hyprpaper;
in
{
  options.mod.hyprpaper = {
    enable = mkEnableOption "Enable hyprpaper config and it's best values";
  };

  config = mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        ipc = "on";
      };
    };
  };
}
