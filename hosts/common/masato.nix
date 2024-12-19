{ ... }:
{
  imports = [
    ./programs/filemanager.nix
    ./programs/neovim.nix
    ./programs/terminal.nix
    ./programs/tools.nix
    ./programs/vpn.nix
    ./programs/zsh.nix
    ./services/dbus.nix
    ./services/ssh.nix
    ./services/dbus.nix
    ./virtualization
    ./users
  ];
}
