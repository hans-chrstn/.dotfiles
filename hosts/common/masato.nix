{ ... }:
{
  imports = [
    ./programs/filemanager.nix
    ./programs/terminal.nix
    ./programs/zsh.nix
    ./programs/neovim.nix
    ./programs/nix-ld.nix
    ./programs/tools.nix
    ./services/greetd.nix
    ./services/dbus.nix
    ./services/nfs.nix
    ./services/clamav.nix
    ./services/docker.nix
    ./users
    ./fonts.nix
  ];
}
