{ ... }:
{
  imports = [
    ./core/masato
    ./core/envar.nix
    ./core/localization.nix
    ./core/nix.nix
    ./core/perf.nix
    ./core/security.nix
    ./core/time.nix
    ./core/xdg.nix

    ./hardware/audio.nix
    ./hardware/bluetooth.nix
    ./hardware/fstrim.nix
    ./hardware/nvidia.nix
    ./hardware/opengl.nix
    ./hardware/firmware.nix
    ./hardware/zram.nix
    # ./hardware/secureboot.nix

    ./filesystem/zfs.nix

    ./network
    ./network/masato.nix
  ];
}
