{ inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.proxmox-nixos.nixosModules.proxmox-ve
  ];

  services.proxmox-ve = {
    enable = true;
    ipAddress = "10.0.0.23";
    vms = {
      nasos = {
        vmid = 100;
        memory = 1024;
        cores = 1;
        sockets = 1;
        kvm = false;
        bios = "ovmf";
        # net = [
        #   {
        #     model = "virtio";
        #     bridge = "vmbr0";
        #   }
        # ];
        scsi = [
          {
            file = "local:32";
          }
        ];
      };
    };
  };

  nixpkgs.overlays = [
    inputs.proxmox-nixos.overlays."x86_64-linux"
  ];
}
