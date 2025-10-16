{ config, lib, ... }:
{
  systemd.network = {
    enable = true;
  };
  networking = {
    networkmanager.enable = lib.mkForce false;
    hostName = "nixos-server";  # DISCOVERABLE NETWORK NAME
    useDHCP = lib.mkForce false;
    firewall = {
      allowedTCPPorts = [
        21025 # starbound
        21026 # starbound
        5173
        3000
        2376
      ];
      allowedUDPPorts = [
        21025 # starbound
        5173
        3000
      ];
      allowedUDPPortRanges = [
      ];
    };
  };
}
