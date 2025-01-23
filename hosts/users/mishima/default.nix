{ outputs, ... }:
{
  imports = [
    ../../common/mishima.nix
    ./overlays.nix
  ];
  # ] ++ (builtins.attrValues outputs.nixosModules);
}
