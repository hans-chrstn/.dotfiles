{ ... }:
{
  imports = [
    ./core/mishima
    ./core/envar.nix
    ./core/localization.nix
    ./core/nix.nix
    ./core/perf.nix
    ./core/security.nix
    ./core/time.nix
    ./core/xdg.nix
    
    ./hardware/audio.nix
    ./hardware/bluetooth.nix
    ./hardware/fstrim.nix
    ./hardware/nvidia.nix
    ./hardware/opengl.nix
    ./hardware/firmware.nix
    ./hardware/secureboot.nix
    #./hardware/print.nix

    ./filesystem

    ./programs/dev.nix
    ./programs/filemanager.nix
    ./programs/misc.nix
    ./programs/package-utils.nix
    ./programs/terminal.nix
    ./programs/zsh.nix
    ./programs/hyprland.nix
    ./programs/ios.nix
    ./programs/neovim.nix
    ./programs/nix-ld.nix
    ./programs/steam.nix
    ./programs/thunar.nix
    ./programs/vpn.nix
    ./programs/wireshark.nix
    ./programs/tools.nix

    ./services/greetd.nix
    ./services/ssh.nix
    ./services/dbus.nix
    ./services/zerotier.nix
    ./services/samba.nix
    ./services/mpd.nix
    ./services/location.nix
    ./services/avahi.nix
    ./services/bolt.nix

    ./network
    ./users
    ./virtualization
  ];
}
