{ config, pkgs, outputs, inputs, lib, ... }:
let
  package = config.boot.kernelPackages.nvidiaPackages.stable;
in
{
  imports = [
    ../../common/masato.nix
    ./overlays.nix
    inputs.proxmox-nixos.nixosModules.proxmox-ve
  ] ++ (builtins.attrValues outputs.nixosModules);

  environment.systemPackages = [
    inputs.hyprsysteminfo.packages.${pkgs.system}.default
    pkgs.arion
  ];

  hardware.nvidia.package = lib.mkForce (pkgs.nvidia-patch.patch-nvenc (pkgs.nvidia-patch.patch-fbc package));

  services.proxmox-ve = {
    enable = true;
    ipAddress = "10.0.0.151";
  };
}
