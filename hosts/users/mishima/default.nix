{ inputs, pkgs, outputs, ... }:
{
  imports = [
    ../../common/mishima.nix
    ./overlays.nix
    inputs.proxmox-nixos.nixosModules.proxmox-ve
  ] ++ (builtins.attrValues outputs.nixosModules);

  environment.systemPackages = [
    pkgs.arion
    pkgs.hyprsysteminfo
  ];

  # services.proxmox-ve = {
  #   enable = true;
  #   ipAddress = "10.0.0.23";
  # };
  homelab.server.ssh.enable = true;
}
