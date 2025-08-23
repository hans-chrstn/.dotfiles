{ config, lib, ... }:
{
  networking = {
    hostName = "nixos-server";  # DISCOVERABLE NETWORK NAME
    firewall = {
      allowedTCPPorts = [
        21025 # starbound
        21026 # starbound
      ];
      allowedUDPPorts = [
        21025 # starbound
      ];
      allowedUDPPortRanges = [
      ];
    };
  };
}
