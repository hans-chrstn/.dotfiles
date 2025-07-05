{ config, lib, ... }:
{
  systemd.network = {
    enable = true;
    networks = {
      "10-lan" = {
        matchConfig = { Name = "enp8s0"; };
        networkConfig = { DHCP = "yes"; };
      };
    };
  };
  networking = {
    hostName = "nixos-main";  # DISCOVERABLE NETWORK NAME
    networkmanager.enable = lib.mkForce false;
    useDHCP = lib.mkForce false;
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
