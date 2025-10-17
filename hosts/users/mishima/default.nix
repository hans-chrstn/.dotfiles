{ config, inputs, lib, pkgs, outputs, ... }:
{
  imports = [
    ../../common/mishima.nix
    ./overlays.nix
  ] ++ (builtins.attrValues outputs.nixosModules);



  mod = {
    ssh.enable = true;
    godot.enable = true;
    wm = {
      niri = {
        enable = true;
        channel = "unstable";
      };
    };
    virtualize = {
      proxmox = {
        enable = true;
        ip = "192.168.110.2";
      };
    };
  };
}
