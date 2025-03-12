{ ... }:
{
  imports = [
    ./programs/filemanager.nix
    ./programs/terminal.nix
    ./programs/zsh.nix
    ./programs/neovim.nix
    ./programs/tools.nix
    ./services/greetd.nix
    ./services/ssh.nix
    ./services/dbus.nix
    ./services/nfs.nix
    ./services/docker.nix
    ./users
    ./fonts.nix
  ];
}
