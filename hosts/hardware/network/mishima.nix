{ config, lib, ... }:
{
  networking = {
    hostName = "nixos-main";  # DISCOVERABLE NETWORK NAME
    firewall = {
      allowedTCPPorts = [
        22
      ];
      allowedUDPPorts = [
      ];
      allowedUDPPortRanges = [
      ];
    };
  };
}
