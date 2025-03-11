{ inputs, lib, pkgs, ... }:
{
  imports = [
    inputs.proxmox-nixos.nixosModules.proxmox-ve
  ];

  services.proxmox-ve = {
    enable = true;
    ipAddress = "10.0.0.23";
  };

  nixpkgs.overlays = [
    inputs.proxmox-nixos.overlays."x86_64-linux"
  ];
}
