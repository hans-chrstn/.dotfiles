{lib, ...}: {
  systemd.network.enable = true;
  networking = {
    networkmanager.enable = lib.mkForce false;
    useDHCP = lib.mkForce false;
  };
}
