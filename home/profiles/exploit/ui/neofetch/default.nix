{ inputs, pkgs, ... }:

{
  home.file.".config/neofetch" = {
    source = ./config;

  };

}
