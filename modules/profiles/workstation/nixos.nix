{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.mod.profiles.workstation;
in {
  options.mod.profiles.workstation = {
    enable = lib.mkEnableOption "Workstation Profile";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      davinci-resolve
      zrythm
      zulu25
      usbutils
    ];
  };
}
