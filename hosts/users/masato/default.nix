{ config, pkgs, outputs, inputs, lib, ... }:
let
  package = config.boot.kernelPackages.nvidiaPackages.stable;
in
{
  imports = [
    ../../common/masato.nix
    ./overlays.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  environment.systemPackages = [
    pkgs.hyprsysteminfo
  ];

  # hardware.nvidia.package = lib.mkForce (pkgs.nvidia-patch.patch-nvenc (pkgs.nvidia-patch.patch-fbc package));

  homelab = {
    server.ssh.enable = true;
    virtualize = {
      incus.enable = true;
    };
  };
}
