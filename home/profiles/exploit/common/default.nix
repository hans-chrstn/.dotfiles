{ lib, config, pkgs, ... }:
let
  apple-fonts = pkgs.callPackage ./ttf/apple-fonts.nix { };
in

{
  fonts.fontconfig.enable = true;
  home.packages = [
    apple-fonts
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
}
