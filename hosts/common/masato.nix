{ ... }:
{
  imports = [
    ./programs/filemanager.nix
    ./programs/terminal.nix
    ./programs/zsh.nix
    ./programs/neovim.nix
    ./programs/tools.nix
    ./services/greetd.nix
    ./services/dbus.nix
    ./services/nfs.nix
    ./services/clamav.nix
    ./services/arion.nix
    ./users
    ./fonts.nix
  ];
}
