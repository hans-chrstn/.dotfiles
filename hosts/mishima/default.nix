{ outputs, ... }:
{
  imports = [
    ../common/mishima.nix
    ./overlays.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  programs.virtualise.enable = true;

  hardware.nvidia-container-toolkit.enable = true;
}
