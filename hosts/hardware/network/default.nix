{ lib, pkgs, ... }:

{
  networking = {
    networkmanager = {
      enable = true;
    };

    firewall = {
      enable = true;
    };
  };
 
 


  security.polkit.enable = true;
  # Don't wait for network startup
  #systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
