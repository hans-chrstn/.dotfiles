{ config, ... }:
{
  imports = [
    ../common/toru.nix
    ./overlays.nix
  ];

  programs.virtualise.enable = true;
}
