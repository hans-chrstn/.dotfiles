{ outputs, ... }:
{
  imports = [
    ../../common/mishima.nix
    ./overlays.nix
  ];
  # ] ++ (builtins.attrValues outputs.nixosModules);

  hardware.nvidia-container-toolkit.enable = true;
}
