{ pkgs, outputs, inputs, ... }:
{
  imports = [
    ../../common/masato.nix
    ./overlays.nix
    inputs.proxmox-nixos.nixosModules.proxmox-ve
  ] ++ (builtins.attrValues outputs.nixosModules);

  environment.systemPackages = [
    inputs.hyprsysteminfo.packages.${pkgs.system}.default
  ];

  services.proxmox-ve = {
    enable = true;
    ipAddress = "10.0.0.151";
  };
}
