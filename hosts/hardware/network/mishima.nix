{ config, lib, ... }:
{
  systemd.network = {
    enable = true;
  };
  networking = {
    hostName = "nixos-main";  # DISCOVERABLE NETWORK NAME
    networkmanager.enable = lib.mkForce false;
    useDHCP = lib.mkForce false;
    firewall = {
      allowedTCPPorts = [
        5173
      ];
      allowedUDPPorts = [
        5173
      ];
      allowedUDPPortRanges = [
      ];
    };
  };
}
