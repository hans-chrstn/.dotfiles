{ ... }:
{
  imports = [
    ./programs/filemanager.nix
    ./programs/misc.nix
    ./programs/terminal.nix
    ./programs/zsh.nix
    ./programs/hyprland.nix
    ./programs/ios.nix
    ./programs/neovim.nix
    ./programs/steam.nix
    ./programs/thunar.nix
    ./programs/vpn.nix
    ./programs/tools.nix
    ./programs/wireshark.nix
    ./services/greetd.nix
    ./services/dbus.nix
    ./services/mpd.nix
    ./services/nfs.nix
    ./services/arion.nix
    ./users
    ./fonts.nix
  ];
}
