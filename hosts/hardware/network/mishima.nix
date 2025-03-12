{ config, lib, ... }:
{
  networking = {
    hostName = "nixos-main";  # DISCOVERABLE NETWORK NAME
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
