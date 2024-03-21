{ lib, config, pkgs, ... }:
let
#  koulen-regular = pkgs.callPackage ./ttf/koulen-regular.nix { };
#  poiretone-regular = pkgs.callPackage ./ttf/poiretone-regular.nix { };
#  phosphor = pkgs.callPackage ./ttf/phosphor.nix { };
  apple-fonts = pkgs.callPackage ./ttf/apple-fonts.nix { };
#  micro5-regular = pkgs.callPackage ./ttf/micro5.nix { };
#  earwigFactory = pkgs.callPackage ./otf/earwigfactory.nix { };
#  forced-square = pkgs.callPackage ./ttf/forced-square.nix { };
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
