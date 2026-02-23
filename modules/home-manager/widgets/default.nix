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
      home.packages = with pkgs; [libnotify networkmanager brightnessctl upower libcava wf-recorder swww kdePackages.qtmultimedia];
    })

    (lib.mkIf cfg.enableQuickshell {
      mod.programs.widgets.enable = true;
      programs.quickshell = {
        enable = true;
        package = inputs.qml-niri.packages.${pkgs.stdenv.hostPlatform.system}.quickshell;
        systemd.enable = true;
      };
    })
  ];
}
