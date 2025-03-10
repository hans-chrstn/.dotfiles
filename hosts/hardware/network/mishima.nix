{ config, lib, ... }:
{
  networking = {
    hostName = "nixos-main";  # DISCOVERABLE NETWORK NAME
    nameservers = [
      "10.0.0.21"
      # # QUAD9
      # "9.9.9.9"
      # "149.112.112.112"
      # "2620:fe::fe"
      # "2620:fe::9"
      # CLOUDFLARE
      # "1.1.1.1"
      # "2606:4700:4700::1111"
      # "1.0.0.1"
      # "2606:4700:4700::1001"
    ];
    firewall = {
      allowedTCPPorts = [
      ];
      allowedUDPPorts = [
        51820
      ];
      allowedUDPPortRanges = [
      ];
    };
  };

 #  services.resolved = {
 #    enable = true;
 #    dnssec = "true";
 #    domains = [ "~." ];
 #    extraConfig = ''
 #      DNSOverTLS=yes
 #      MulticastDNS=resolve
 #    '';
 #    llmnr = "true";
 # };
}
