{ config, pkgs, outputs, inputs, lib, ... }:
{
  imports = [
    ../../common/hayato.nix
    ./overlays.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  environment.systemPackages = [
    pkgs.hyprsysteminfo
  ];

  mod = {
    ssh.enable = true;
    godot.enable = true;
    wm.niri = {
      enable = true;
      # channel = "unstable";
    };
  };
}
