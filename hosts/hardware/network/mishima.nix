{ ... }:
{
  networking = {
    hostName = "nixos";  # DISCOVERABLE NETWORK NAME
    nameservers = [
      # NEXTDNS
      #"45.90.28.0#25f5a7.dns.nextdns.io"
      #"2a07:a8c0::#25f5a7.dns.nextdns.io"
      #"45.90.30.0#25f5a7.dns.nextdns.io"
      #"2a07:a8c1::#25f5a7.dns.nextdns.io"
      # QUAD9
      "9.9.9.9"
      "149.112.112.112"
      "2620:fe::fe"
      "2620:fe::9"
      # CLOUDFLARE
      "1.1.1.1"
      "2606:4700:4700::1111"
      "1.0.0.1"
      "2606:4700:4700::1001"

    ];
    firewall = {
      allowedTCPPorts = [
        47984
        47989
        47990
        48010
      ];
      allowedUDPPorts = [
        51820
      ];
      allowedUDPPortRanges = [
        { from = 47998; to = 48000; }
        { from = 8000; to = 8010; }
      ];
    };
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    extraConfig = ''
      DNSOverTLS=yes
      MulticastDNS=resolve
    '';
    llmnr = "true";
 };
}
