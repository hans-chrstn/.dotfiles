{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      "users/jin/password" = {
        neededForUsers = true;
      };
      "users/jin/ssh/public" = {};
      "networks/jin/main/name" = {};
      "networks/jin/main/dhcp" = {};
      "networks/jin/vm/kind" = {};
      "networks/jin/vm/name" = {};
      "networks/jin/bridge/name" = {};
      "networks/jin/bridge/dhcp" = {};
      "networks/jin/bridge/mad" = {};
      "networks/makoto/bridge/mad" = {};
      "networks/makoto/ip" = {};
    };
    templates = {
      "wol-interface" = {
        content = ''
          INTERFACE_NAME=${config.sops.placeholder."networks/jin/main/name"}
        '';
      };

      "wol-servers" = {
        content = ''
          MAKOTO_MAC=${config.sops.placeholder."networks/makoto/bridge/mad"}
          MAKOTO_IP=${config.sops.placeholder."networks/makoto/ip"}
        '';
      };

      "10-lan.network" = {
        content = ''
          [Match]
          Name=${config.sops.placeholder."networks/jin/main/name"}

          [Link]
          MACAddress=${config.sops.placeholder."networks/jin/bridge/mad"}
          WakeOnLan=magic

          [Network]
          DHCP=${config.sops.placeholder."networks/jin/main/dhcp"}
        '';
        # NETWORK Bridge=${config.sops.placeholder."networks/jin/vm/name"}
        mode = "0644";
        path = "/etc/systemd/network/10-lan.network";
      };

      #      "10-lan-bridge.network" = {
      #        content = ''
      #          [Match]
      #          Name=${config.sops.placeholder."networks/jin/bridge/name"}
      #
      #          [Link]
      #          RequiredForOnline=routable
      #          MACAddress=${config.sops.placeholder."networks/jin/bridge/mad"}
      #
      #          [Network]
      #          DHCP=${config.sops.placeholder."networks/jin/bridge/dhcp"}
      #        '';
      #        mode = "0644";
      #        path = "/etc/systemd/network/10-lan-bridge.network";
      #      };
      #
      #      "vmbr0.netdev" = {
      #        content = ''
      #          [NetDev]
      #          Kind=${config.sops.placeholder."networks/jin/vm/kind"}
      #          Name=${config.sops.placeholder."networks/jin/vm/name"}
      #        '';
      #        mode = "0644";
      #        path = "/etc/systemd/network/vmbr0.netdev";
      #      };
    };
  };
}
