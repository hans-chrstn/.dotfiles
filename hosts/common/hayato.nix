{ ... }:
{
  imports = [
    ./programs/dell.nix
    ./programs/filemanager.nix
    ./programs/terminal.nix
    ./programs/zsh.nix
    ./programs/neovim.nix
    ./programs/tools.nix
    ./programs/thunar.nix
    ./programs/vpn.nix
    ./programs/nix-ld.nix
    ./programs/steam.nix
    ./services/greetd.nix
    ./services/dbus.nix
    ./services/nfs.nix
    ./users
    ./fonts.nix
  ];
}
