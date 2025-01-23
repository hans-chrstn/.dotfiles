{ inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.proxmox-nixos.nixosModules.proxmox-ve
  ];

  services.proxmox-ve = {
    enable = true;
    ipAddress = "10.0.0.55";
    vms = {
      gaming = {
        vmid = 100;
        memory = 8192;
        cores = 8;
        sockets = 1;
        kvm = false;
        net = [
          {
            model = "virtio";
            bridge = "vmbr0";
          }
        ];
        scsi = [
          {
            file = "local:200";
          }
        ];
      };
    };
  };

  nixpkgs.overlays = [
    inputs.proxmox-nixos.overlays."x86_64-linux"
  ];
}
