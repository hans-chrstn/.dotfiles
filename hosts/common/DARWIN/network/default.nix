{ ... }:
{
  networking = {
    computerName = "nix-darwin";
    hostName = "nix-darwin";

    dns = [

    ];

    knownNetworkServices = [
      "Ethernet"
      "802.11ac NIC"
    ];
  };

  # FIREWALL
  
  system = {
    defaults = {
      alf = {
        allowdownloadsignedenabled = 0;
        allowsignedenabled = 1;
        globalstate = 0;
        loggingenabled = 0;
        stealthenabled = 0;
      };
    };
  };
}
