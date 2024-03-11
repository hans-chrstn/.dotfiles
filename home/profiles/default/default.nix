{ config, pkgs, inputs, ... }:

{
  imports = [
    ./home.nix
    ./programs.nix
    ./programs
    ./fonts/fonts.nix
    ./ui
  ];
}
