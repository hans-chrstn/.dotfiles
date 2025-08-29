{ config, pkgs, outputs, inputs, lib, ... }:
{
  imports = [
    ../../common/hayato.nix
    ./overlays.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  environment.systemPackages = [
    pkgs.hyprsysteminfo
  ];

  homelab = {
    server.ssh.enable = true;
    godot.enable = true;
  };
}
