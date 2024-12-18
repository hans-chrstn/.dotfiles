{ ... }:
{
  networking = {
    hostName = "nixos-server";
    interfaces = {
      enp5s0 = {
        ipv4.addresses = [{
          address = "10.0.0.17";
          prefixLength = 24;
        }];
      };
    };
    defaultGateway = {
      address = "10.0.0.1";
      interface = "enp5s0";
    };
  };
}
