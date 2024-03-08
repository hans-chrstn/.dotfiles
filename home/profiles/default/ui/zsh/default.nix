{ inputs, pkgs, ... }:

{
  home.file.".zshrc" = {
    source = ./config;

  };

}
