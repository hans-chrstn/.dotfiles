{ inputs, pkgs, outputs, ... }:
{
  imports = [
    ../../common/mishima.nix
    ./overlays.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  environment.systemPackages = [
    inputs.hyprsysteminfo.packages.${pkgs.system}.default
  ];

  programs.virtualise = {
    enable = true;
    proxmoxIP = "10.0.0.23";
  };
}
