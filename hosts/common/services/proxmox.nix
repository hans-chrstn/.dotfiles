{ inputs, lib, pkgs, ... }:
{


  nixpkgs.overlays = [
    inputs.proxmox-nixos.overlays."x86_64-linux"
  ];
}
