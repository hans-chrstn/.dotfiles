{ config, lib, pkgs, ... }:

{
  imports = [
    ./location.nix
    ./power-button.nix
    ./tlp.nix
    ./gnome-services.nix
    ./greetd.nix


  ];

  #screensharing
  services.dbus = {
    enable = true;
    implementation = "broker";

  };

  #hint electron apps to use wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";

  };


}
