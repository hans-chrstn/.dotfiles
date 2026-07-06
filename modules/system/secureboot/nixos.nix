{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.mod.hardware.secureboot;
  hasLanzaboote = builtins.hasAttr "lanzaboote" inputs;
in {
  imports = lib.optional hasLanzaboote inputs.lanzaboote.nixosModules.lanzaboote;

  options.mod.hardware.secureboot = {
    enable = lib.mkEnableOption "Enable the secureboot feature";
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      boot.loader.systemd-boot.enable = lib.mkForce false;
    })
    (lib.optionalAttrs hasLanzaboote {
      boot = lib.mkIf cfg.enable {
        lanzaboote = {
          enable = true;
          pkiBundle = "/etc/secureboot";
        };
      };
    })
  ];
}
