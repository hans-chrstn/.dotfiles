{ lib, ... }:

{
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Don't wait for network startup
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
