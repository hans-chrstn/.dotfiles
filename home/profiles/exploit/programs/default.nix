{ config, pkgs, ... }:

{
  imports = [
    ./git
    ./zsh
    ./neovim
    ./spicetify
    ./nix-index
    ./vscode
  ];
}
