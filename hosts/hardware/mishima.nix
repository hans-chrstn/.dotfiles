{ ... }:
{
  imports = [
    ./core/mishima
    ./core/envar.nix
    ./core/localization.nix
    ./core/nix.nix
    ./core/security.nix
    ./core/time.nix
    ./core/xdg.nix

    ./hardware/audio.nix
    ./hardware/fstrim.nix
    ./hardware/nvidia.nix
    ./hardware/opengl.nix
    ./hardware/firmware.nix
    ./hardware/zram.nix
    # ./hardware/secureboot.nix

    ./filesystem
    ./network
    ./network/mishima.nix
  ];
}
