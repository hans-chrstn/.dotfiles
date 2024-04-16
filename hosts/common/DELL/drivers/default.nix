{ config, lib, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./print.nix
    ./touchpad.nix
    ./bluetooth.nix
    ./fstrim.nix

  ];

}
