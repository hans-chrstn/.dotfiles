{ config, ... }:
{
  home.file.".config/kitty" = {
    source = ./config;
  };
  programs.kitty = {
    enable = true;
  };
}
