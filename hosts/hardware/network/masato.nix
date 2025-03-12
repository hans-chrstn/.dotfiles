{ config, lib, ... }:
{
  networking = {
    hostName = "nixos-server";  # DISCOVERABLE NETWORK NAME
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
