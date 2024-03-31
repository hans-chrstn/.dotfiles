{ lib, config, pkgs, ... }:
let
  apple-fonts = pkgs.callPackage ./ttf/apple-fonts.nix { };
  weathericonserik = pkgs.callPackage ./icons/erikweather.nix { };
in

{
  fonts.fontconfig.enable = true;
  home.packages = [
    weathericonserik
    apple-fonts
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
}
