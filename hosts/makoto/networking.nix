{lib, ...}: {
  systemd.network.enable = true;
  networking = {
    networkmanager.enable = lib.mkForce false;
    useDHCP = lib.mkForce false;
    firewall = {
      allowedTCPPorts = [];
      allowedUDPPorts = [69];
      allowedUDPPortRanges = [
        {
          from = 16261;
          to = 16271;
        }
      ];
    };
  };
}
