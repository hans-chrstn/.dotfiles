{ config, lib, pkgs, ... }:

{
  imports = [
    ./location.nix
    ./power-button.nix
    ./tlp.nix

  ];

  #screensharing
  services.dbus.enable = true;

  #hint electron apps to use wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";

  };


}
