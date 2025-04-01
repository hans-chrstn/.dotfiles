{ config, lib, ... }:
{
  networking = {
    hostName = "nixos-server";  # DISCOVERABLE NETWORK NAME
    firewall = {
      allowedTCPPorts = [
        # 22
      ];
      allowedUDPPorts = [
      ];
      allowedUDPPortRanges = [
      ];
    };
  };
}
