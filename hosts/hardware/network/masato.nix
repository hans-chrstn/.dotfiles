{ pkgs, ... }:
{
  networking = {
    firewall = {
     enable = true;
     allowedUDPPorts = [ 51820 ];
     allowedTCPPorts = [];
    };
    hostName = "nixos-server";
    nat = {
      externalInterface = "enp5s0";
      internalInterfaces = [ "wg0" ];
    };
    wireguard = {
      enable = true;
      interfaces = {
        wg0 = {
          # This allows the wireguard server to route your traffic to the internet and hence be like a VPN
          # For this to work you have to set the dnsserver IP of your router (or dnsserver of choice) in your clients
          postSetup = ''
            ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o enp5s0 -j MASQUERADE
          '';

          # This undoes the above command
          postShutdown = ''
            ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o enp5s0 -j MASQUERADE
          '';
          ips = [ "10.100.0.1/24" ];
	  listenPort = 51820;
	  privateKeyFile = "/home/masato/wgkeys/private";
	  peers = [
            {
              publicKey = "iJdQeucnrSFv2a1oKzwo8akwo7JCsU3xzNA35TfsNiU=";
	      allowedIPs = [ "10.100.0.2" ];
	    }
	  ];
	};
      };
    };
  };
  security.polkit.enable = true;
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = "1";
    "net.ipv6.conf.all.forwarding" = "1";
  };
}
