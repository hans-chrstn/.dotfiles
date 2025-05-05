{ config, lib, ... }:
{
  networking = {
    hostName = "nixos-main";  # DISCOVERABLE NETWORK NAME
    networkmanager.enable = lib.mkForce false;
    firewall = {
      allowedTCPPorts = [
      ];
      allowedUDPPorts = [
      ];
      allowedUDPPortRanges = [
      ];
    };
  };
}
