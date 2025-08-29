{ config, lib, ... }:
{
  networking = {
    hostName = "hayato";  # DISCOVERABLE NETWORK NAME
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
