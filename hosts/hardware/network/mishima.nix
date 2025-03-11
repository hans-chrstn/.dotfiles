{ config, lib, ... }:
{
  networking = {
    hostName = "nixos-main";  # DISCOVERABLE NETWORK NAME
    firewall = {
      allowedTCPPorts = [
      ];
      allowedUDPPorts = [
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
