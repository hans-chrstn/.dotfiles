{ ... }:
{

  imports = [
    ./core/masato
    ./core/localization.nix
    ./core/nix.nix
    ./core/perf.nix
    ./core/security.nix
    ./core/time.nix
    ./hardware/firmware.nix
    ./network
    ./network/masato.nix
  ];
}
