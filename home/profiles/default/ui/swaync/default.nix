{ inputs, pkgs, ... }:

{
  home.file.".config/swaync" = {
    source = ./config;

  };

}
