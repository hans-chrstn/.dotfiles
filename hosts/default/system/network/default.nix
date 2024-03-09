{ lib, ... }:

{
  networking.hostName = "nixos";
  
  networking = {
    networkmanager = {
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
