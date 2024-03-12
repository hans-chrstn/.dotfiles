{ config, pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = [
    (pkgs.google-fonts.override { fonts = ["Poiret One"]; })
    (pkgs.google-fonts.override { fonts = ["Koulen"]; })
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];
}
