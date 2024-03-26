{ lib, config, pkgs, ... }:
let
  apple-fonts = pkgs.callPackage ./ttf/apple-fonts.nix { };
in

{
  fonts.fontconfig.enable = true;
  home.packages = [
#    forced-square
#    earwigFactory
#    micro5-regular
    apple-fonts
#    poiretone-regular
#    phosphor
#    koulen-regular
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
}
