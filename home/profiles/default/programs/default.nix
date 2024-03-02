{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./zsh.nix
    ./neovim.nix
    ./spicetify.nix
    ./nix-index.nix
  ];
}
