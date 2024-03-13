{ lib, config, pkgs, ... }:
let
  koulen-regular = pkgs.callPackage ./ttf/koulen-regular.nix { };
  poiretone-regular = pkgs.callPackage ./ttf/poiretone-regular.nix { };
  phosphor = pkgs.callPackage ./ttf/phosphor.nix { };
  apple-fonts = pkgs.callPackage ./ttf/apple-fonts.nix { };
in

{
  fonts.fontconfig.enable = true;
  home.packages = [
    apple-fonts
    poiretone-regular
    phosphor
    koulen-regular
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
}
