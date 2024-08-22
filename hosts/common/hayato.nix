{ ... }:
{
  imports = [
    ./core/hayato
    ./core/envar.nix
    ./core/localization.nix
    ./core/nix.nix
    ./core/perf.nix
    ./core/security.nix
    ./core/time.nix
    ./core/xdg.nix
    
    ./hardware/audio.nix
    ./hardware/bluetooth.nix
    #./hardware/fstrim.nix
    #./hardware/nvidia.nix
    ./hardware/opengl.nix
    ./hardware/firmware.nix
    ./hardware/print.nix
    ./hardware/touchpad.nix

    ./programs/dev.nix
    ./programs/dell.nix
    ./programs/filemanager.nix
    ./programs/misc.nix
    ./programs/package-utils.nix
    ./programs/terminal.nix
    ./programs/tools.nix

    ./services/greetd.nix
    ./services/ssh.nix
    ./services/dbus.nix
    ./services/zerotier.nix
    ./services/samba.nix
    ./services/mpd.nix
    ./services/location.nix
    ./services/gnome-services.nix
    ./services/avahi.nix
    ./services/bolt.nix

    ./network
    ./users
    ./virtualization
  ];
}
