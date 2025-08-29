{ ... }:
{
  imports = [
    ./core/hayato
    ./core/envar.nix
    ./core/localization.nix
    ./core/nix.nix
    ./core/perf.nix
    ./core/security.nix
    ./core/time.nix
    ./core/xdg.nix
    ./core/sops.nix

    ./hardware/audio.nix
    ./hardware/bluetooth.nix
    ./hardware/fstrim.nix
    ./hardware/opengl.nix
    ./hardware/firmware.nix
    ./hardware/zram.nix
    ./hardware/print.nix
    ./hardware/touchpad.nix

    ./network
    ./network/hayato.nix

    ./filesystem
  ];
}
