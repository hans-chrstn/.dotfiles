{ config, pkgs, outputs, inputs, lib, ... }:
{
  imports = [
    ../../common/masato.nix
    ./overlays.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  environment.systemPackages = [
    pkgs.hyprsysteminfo
  ];

  homelab = {
    server.ssh.enable = true;
  };
}
