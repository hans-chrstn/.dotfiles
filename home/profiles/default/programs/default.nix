{ config, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./zsh.nix
    ./neovim.nix
  ];
}
