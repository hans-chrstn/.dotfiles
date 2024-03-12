{ inputs, pkgs, ... }:

{
  #DEPRECATED. USE configDir
  #home.file.".config/eww" = {
  #  source = ./config;
  #
  #};

  programs.eww = {
    enable = true;
    configDir = ./config;


  };
  


}
