{ inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.proxmox-nixos.nixosModules.proxmox-ve
  ];

  networking = {
    interfaces = {
      vmbr0 = {
        useDHCP = lib.mkDefault true;
      };
    };
    bridges = {
      vmbr0 = {
        interfaces = [ "enp8s0" ];
      };
    };
  };

  services.proxmox-ve = {
    enable = true;
    ipAddress = "10.0.0.150";
    vms = {
      nasos = {
        vmid = 100;
        memory = 1024;
        cores = 1;
        sockets = 1;
        kvm = false;
        bios = "ovmf";
        net = [
          {
            model = "virtio";
            bridge = "vmbr0";
          }
        ];
        scsi = [
          {
            file = "local:16";
          }
        ];
      };
    };
  };

  nixpkgs.overlays = [
    inputs.proxmox-nixos.overlays."x86_64-linux"
  ];
}
