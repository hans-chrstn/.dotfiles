{ ... }:
{
  imports = [
    ./core/toru
    ./core/nix.nix
    ./core/time.nix
    ./core/security.nix
    ./core/envar.nix
    ./core/localization.nix
    ./programs/zsh.nix
    ./programs/neovim.nix
    ./users
  ];
}