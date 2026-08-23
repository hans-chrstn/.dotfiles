{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.dotfiles.hardware.via;
in {
  options.dotfiles.hardware.via = {
    enable = lib.mkEnableOption "Enable the VIA";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      via
    ];

    services.udev.packages = with pkgs; [via];
  };
}
