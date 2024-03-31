{ pkgs, ... }:

{

  #workaround the ssh issue
  services.sshd.enable = false;

  imports = [
    ./location.nix
    ./power-button.nix
    ./tlp.nix
    ./gnome-services.nix
    ./greetd.nix
    ./logind.nix
    ./mpd.nix


  ];

  #screensharing
  services = {
#    tumbler.enable = true;
    gvfs.enable = true;
    gnome = {
      sushi.enable = true;
      gnome-keyring.enable = true;
    };
    dbus = {
      enable = true;
      implementation = "dbus";
    };
  };


  #portals
  xdg.portal = {
    enable = true;
#    wlr.enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk 
      pkgs.xdg-desktop-portal
    ];
  }; 


}
