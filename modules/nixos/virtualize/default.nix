{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.mod.virtualize;
in {
  imports = [
    inputs.proxmox-nixos.nixosModules.proxmox-ve
  ];

  options.mod.virtualize = {
    qemu.enable = lib.mkEnableOption "Enable virtualization modules and packages";
    incus.enable = lib.mkEnableOption "Enable incus modules and packages";
    waydroid.enable = lib.mkEnableOption "Enable waydroid modules and packages";
    proxmox.enable = lib.mkEnableOption "Enable Proxmox-Nixos modules";
    proxmox.ip = lib.mkOption {
      type = lib.types.str;
      default = "192.168.0.1";
      description = "IP address to assign the the Proxmox VE service";
    };
    docker = {
      enable = lib.mkEnableOption "Enable docker";
      extraOptions = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Extra options to add to docker service";
      };
      enableNvidiaSupport = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable nvidia support using nvidia-container-toolkit";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.qemu.enable {
      virtualisation = {
        libvirtd = {
          enable = true;
          qemu = {
            swtpm.enable = true;
            ovmf.enable = true;
            ovmf.packages = [pkgs.OVMFFull.fd];
          };
        };
        spiceUSBRedirection.enable = true;
      };
      services.spice-vdagentd.enable = true;
    })

    (lib.mkIf cfg.incus.enable {
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
            allowedTCPPorts = [
              53
              67
            ];
            allowedUDPPorts = [
              53
              67
            ];
          };
        };
      };
    })

    (lib.mkIf cfg.waydroid.enable {
      virtualisation = {
        waydroid = {
          enable = true;
        };
      };
    })

    (lib.mkIf cfg.proxmox.enable {
      services.proxmox-ve = {
        enable = true;
        ipAddress = cfg.proxmox.ip;
      };
    })

    (lib.mkIf cfg.docker.enable {
      virtualisation.docker = {
        enable = true;
        storageDriver = "overlay2";
        extraOptions = cfg.docker.extraOptions;
      };
      environment.systemPackages = with pkgs; [docker-compose];

      hardware.nvidia-container-toolkit.enable = cfg.docker.enableNvidiaSupport;
    })
  ];
}
