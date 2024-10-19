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
    ./hardware/audio.nix
    ./hardware/bluetooth.nix
    ./hardware/opengl.nix
    ./hardware/firmware.nix
    ./hardware/print.nix
    ./hardware/touchpad.nix
    ./network
  ];
}
