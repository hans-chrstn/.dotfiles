{ lib, ... }:

{
  networking.hostName = "nixos";
  
  #nextdns
  networking = {
    #nameservers = [
    #  "45.90.28.0"
    #  "45.90.30.0"
    #  "2a07:a8c0::56:47dd"
    #  "2a07:a8c1::56:47dd"
    #];
    networkmanager = {
    #  dns = "systemd-resolved";
      enable = true;
    };
  };

  services.resolved = {
    enable = true;
    extraConfig = ''
      [Resolve]
      DNS=45.90.28.0#5647dd.dns.nextdns.io
      DNS=2a07:a8c0::#5647dd.dns.nextdns.io
      DNS=45.90.30.0#5647dd.dns.nextdns.io
      DNS=2a07:a8c1::#5647dd.dns.nextdns.io
      DNSOverTLS=yes
    '';

  };

  # Don't wait for network startup
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
}
