{ pkgs, ... }:

{

  imports = [
    ./envar.nix
    ./location.nix
    ./gnome-services.nix
    ./greetd.nix
    ./logind.nix
    ./mpd.nix
    ./dbus.nix
    ./portals.nix
  ];

 


}
