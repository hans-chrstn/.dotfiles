{ lib, ... }:
{
  networking = {
    useDHCP = lib.mkForce false;
    networkmanager.enable = lib.mkForce false;
    hostName = "nixos-main";  # DISCOVERABLE NETWORK NAME
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
      ];
      allowedUDPPorts = [
      ];
      allowedUDPPortRanges = [
      ];
    };
  };

  systemd.network = {
    enable = true;
    networks = {
      "10-lan" = {
        matchConfig.Name = [ "enp8s0" ];
        networkConfig = {
          Description = "My Lan";
          Bridge = "vmbr0";
        };
      };
      "10-lan-bridge" = {
        matchConfig.Name = "vmbr0";
        networkConfig = {
          DHCP = "no";
          Address = "10.0.0.54/24";
          Gateway = "10.0.0.1";
        };
        linkConfig.RequiredForOnline = "routable";
      };
    };
    netdevs = {
      "vmbr0" = {
        netdevConfig = {
          Name = "vmbr0";
          Kind = "bridge";
        };
      };
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
