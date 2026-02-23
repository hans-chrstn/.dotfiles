{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.mod.programs.widgets;
in {
  options.mod.programs.widgets = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable all widget dependencies installed";
    };
    enableQuickshell = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Quickshell";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      services.playerctld.enable = true;
      home.packages = with pkgs; [libnotify networkmanager brightnessctl];
    })

    (lib.mkIf cfg.enableQuickshell {
      programs.quickshell = {
        enable = true;
        systemd.enable = true;
      };
    })
  ];
}
