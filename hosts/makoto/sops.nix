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
      "networks/makoto/main/name" = {};
      "networks/makoto/main/dhcp" = {};
      "networks/makoto/vm/kind" = {};
      "networks/makoto/vm/name" = {};
      "networks/makoto/bridge/name" = {};
      "networks/makoto/bridge/dhcp" = {};
      "networks/makoto/bridge/mad" = {};
      "users/rei/bcsi/pool_name" = {};
      "users/rei/bcsi/target_ip" = {};
      "users/rei/bcsi/wwn" = {};
      "users/rei/bcsi/chap/node" = {};
    };
    templates = {
      "iscsi-config" = {
        content = ''
          TARGET_IP=${config.sops.placeholder."users/rei/bcsi/target_ip"}
          TARGET_IQN=${config.sops.placeholder."users/rei/bcsi/wwn"}
          INITIATOR_IQN=${config.sops.placeholder."users/rei/bcsi/chap/node"}
          POOL_NAME=${config.sops.placeholder."users/rei/bcsi/pool_name"}
        '';
      };
      "10-lan.network" = {
        content = ''
          [Match]
          Name=${config.sops.placeholder."networks/makoto/main/name"}

          [Network]
          Bridge=${config.sops.placeholder."networks/makoto/vm/name"}
          DHCP=${config.sops.placeholder."networks/makoto/main/dhcp"}
        '';
        mode = "0644";
        path = "/etc/systemd/network/10-lan.network";
      };

      "10-lan-bridge.network" = {
        content = ''
          [Match]
          Name=${config.sops.placeholder."networks/makoto/bridge/name"}

          [Link]
          RequiredForOnline=routable
          MACAddress=${config.sops.placeholder."networks/makoto/bridge/mad"}

          [Network]
          DHCP=${config.sops.placeholder."networks/makoto/bridge/dhcp"}
        '';
        mode = "0644";
        path = "/etc/systemd/network/10-lan-bridge.network";
      };

      "vmbr0.netdev" = {
        content = ''
          [NetDev]
          Kind=${config.sops.placeholder."networks/makoto/vm/kind"}
          Name=${config.sops.placeholder."networks/makoto/vm/name"}
        '';
        mode = "0644";
        path = "/etc/systemd/network/vmbr0.netdev";
      };
    };
  };
}
