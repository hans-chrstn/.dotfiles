{ config, inputs, lib, pkgs, outputs, ... }:
{
  imports = [
    ../../common/mishima.nix
    ./overlays.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  homelab = {
    server.ssh.enable = true;
    godot.enable = true;
    virtualize = {
      proxmox = {
        enable = true;
        ip = "192.168.110.2";
      };
    };
  };
}
