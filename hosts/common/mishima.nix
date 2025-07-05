{ ... }:
{
  imports = [
    ./programs/filemanager.nix
    ./programs/misc.nix
    ./programs/terminal.nix
    ./programs/zsh.nix
    ./programs/hyprland.nix
    ./programs/neovim.nix
    ./programs/steam.nix
    ./programs/thunar.nix
    ./programs/vpn.nix
    ./programs/tools.nix
    ./programs/wireshark.nix
    ./programs/gamemode.nix
    ./programs/nix-ld.nix
    ./services/greetd.nix
    ./services/dbus.nix
    ./services/nfs.nix
    ./users
    ./fonts.nix
  ];
}
