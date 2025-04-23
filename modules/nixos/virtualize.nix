{ inputs, lib, pkgs, config, ... }:
with lib;
let
 cfg = config.homelab.virtualize;
in 
{
  options.homelab.virtualize = {
    qemu.enable = mkEnableOption "Enable virtualization modules and packages";
    incus.enable = mkEnableOption "Enable incus modules and packages";
    waydroid.enable = mkEnableOption "Enable waydroid modules and packages";

  };

  config = mkMerge [
    (mkIf cfg.qemu.enable {
      virtualisation = {
        libvirtd = {
          enable = true;
          qemu = {
            swtpm.enable = true;
            ovmf.enable = true;
            ovmf.packages = [ pkgs.OVMFFull.fd ];
          };
        };
        spiceUSBRedirection.enable = true;
      };
      services.spice-vdagentd.enable = true;
    })

    (mkIf cfg.incus.enable {
      virtualisation = {
        incus = {
          enable = true;
          ui.enable = true;
        };
      };
      networking = {
        nftables.enable = true;
        firewall = {
          enable = true;
          allowedTCPPorts = [
            8443
          ];
          interfaces.incusbr0 = {

            allowedTCPPorts = [53 67];
            allowedUDPPorts = [53 67];
          };
        };
      };
    })

    (mkIf cfg.waydroid.enable {
      virtualisation = {
        waydroid = {
          enable = true;
        };
      };
    })
  ];
}
