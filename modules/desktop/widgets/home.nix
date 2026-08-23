{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.dotfiles.desktop.widgets;
in {
  options.dotfiles.desktop.widgets = {
    enable = lib.mkEnableOption "widget dependencies";
    quickshell.enable = lib.mkEnableOption "Quickshell widgets";
    quickshell.systemd.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable the Quickshell systemd service";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      services.playerctld.enable = true;
      home.packages = with pkgs; [wl-clipboard-rs libnotify networkmanager brightnessctl upower libcava wf-recorder awww kdePackages.qtmultimedia kdePackages.qtutilities gcalcli pulseaudio];
    })

    (lib.mkIf cfg.quickshell.enable {
      dotfiles.desktop.widgets.enable = true;
      programs.quickshell = {
        enable = true;
        package = inputs.dotquickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
        systemd.enable = cfg.quickshell.systemd.enable;
      };
    })
  ];
}
