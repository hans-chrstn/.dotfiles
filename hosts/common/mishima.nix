{ ... }:
{
  imports = [
    ./programs/dev.nix
    ./programs/filemanager.nix
    ./programs/misc.nix
    ./programs/package-utils.nix
    ./programs/terminal.nix
    ./programs/zsh.nix
    ./programs/hyprland.nix
    ./programs/ios.nix
    ./programs/neovim.nix
    ./programs/steam.nix
    ./programs/thunar.nix
    ./programs/vpn.nix
    ./programs/tools.nix
    ./services/greetd.nix
    ./services/ssh.nix
    ./services/dbus.nix
    ./services/mpd.nix
    ./users
    ./virtualization
  ];
}
