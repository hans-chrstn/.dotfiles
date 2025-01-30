{ inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.proxmox-nixos.nixosModules.proxmox-ve
  ];

  services.proxmox-ve = {
    enable = true;
    ipAddress = "10.0.0.150";
    vms = {
      nasos = {
        vmid = 100;
        memory = 8192;
        cores = 4;
        sockets = 2;
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
            file = "local:100";
          }
        ];
      };
    };
  };

  nixpkgs.overlays = [
    inputs.proxmox-nixos.overlays."x86_64-linux"
  ];
}
