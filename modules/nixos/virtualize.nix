{ inputs, lib, pkgs, config, ... }:
with lib;
let
 cfg = config.mod.virtualize;
in 
{
  imports = [
    inputs.proxmox-nixos.nixosModules.proxmox-ve
  ];

  options.mod.virtualize = {
    qemu.enable = mkEnableOption "Enable virtualization modules and packages";
    incus.enable = mkEnableOption "Enable incus modules and packages";
    waydroid.enable = mkEnableOption "Enable waydroid modules and packages";
    proxmox.enable = mkEnableOption "Enable Proxmox-Nixos modules";
    proxmox.ip = mkOption {
      type = types.str;
      default = "192.168.0.1";
      description = "IP address to assign the the Proxmox VE service";
    };

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

    (mkIf cfg.proxmox.enable {
      services.proxmox-ve = {
        enable = true;
        ipAddress = cfg.proxmox.ip;
      };

      nixpkgs.overlays = [
        inputs.proxmox-nixos.overlays."x86_64-linux"
      ];
    })
  ];
}
