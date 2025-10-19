{ inputs, lib, config, ... }:
let
  cfg = config.mod.hardware.secureboot;
in
{
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  options.mod.hardware.secureboot = {
    enable = lib.mkEnableOption "Enable the secureboot feature";
  };

  config = lib.mkIf cfg.enable {
    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };
}
