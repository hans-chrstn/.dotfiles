{ config, lib, ... }:
{
  networking = {
    hostName = "nixos-server";  # DISCOVERABLE NETWORK NAME
    firewall = {
      allowedTCPPorts = [
        22
      ];
      allowedUDPPorts = [
        51820
      ];
      allowedUDPPortRanges = [
      ];
    };
  };
}
