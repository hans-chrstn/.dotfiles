{ pkgs, outputs, inputs, ... }:
{
  imports = [
    ../../common/masato.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  environment.systemPackages = [
    inputs.hyprsysteminfo.packages.${pkgs.system}.default
  ];
}
