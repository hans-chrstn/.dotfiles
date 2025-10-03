{ config, pkgs, inputs, ...}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    age
    gnupg
    sops
    ssh-to-age
  ];

  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
    secrets = {
      "users/mishima/password" = {};
      "networks/wg-laptop/interface/private-key" = {};
      "networks/wg-laptop/interface/address" = {};
      "networks/wg-laptop/interface/dns" = {};
      "networks/wg-laptop/peer/public-key" = {};
      "networks/wg-laptop/peer/preshared-key" = {};
      "networks/wg-laptop/peer/allowed-ips" = {};
      "networks/wg-laptop/peer/endpoint" = {};
      "networks/mishima/main/name" = {};
      "networks/mishima/main/dhcp" = {};
      "networks/mishima/vm/kind" = {};
      "networks/mishima/vm/name" = {};
      "networks/mishima/bridge/name" = {};
      "networks/mishima/bridge/dhcp" = {};
      "networks/mishima/bridge/mad" = {};
    };
    templates = {
      "unsecured" = {
        content = ''
          [Interface]
          PrivateKey = ${config.sops.placeholder."networks/wg-laptop/interface/private-key"}
          Address = ${config.sops.placeholder."networks/wg-laptop/interface/address"}
          DNS = ${config.sops.placeholder."networks/wg-laptop/interface/dns"}

          [Peer]
          PublicKey = ${config.sops.placeholder."networks/wg-laptop/peer/public-key"}
          PresharedKey = ${config.sops.placeholder."networks/wg-laptop/peer/preshared-key"}
          AllowedIPs = ${config.sops.placeholder."networks/wg-laptop/peer/allowed-ips"}
          Endpoint = ${config.sops.placeholder."networks/wg-laptop/peer/endpoint"}
          PersistentKeepalive = 25
        '';
        path = "/etc/wireguard/unsecured.conf";
      };

      "10-lan.network" = {
        content = ''
          [Match]
          Name=${config.sops.placeholder."networks/mishima/main/name"}

          [Network]
          Bridge=${config.sops.placeholder."networks/mishima/vm/name"}
          DHCP=${config.sops.placeholder."networks/mishima/main/dhcp"}
        '';
        mode = "0644";
        path = "/etc/systemd/network/10-lan.network";
      };

      "10-lan-bridge.network" = {
        content = ''
          [Match]
          Name=${config.sops.placeholder."networks/mishima/bridge/name"}

          [Link]
          RequiredForOnline=routable
          MACAddress=${config.sops.placeholder."networks/mishima/bridge/mad"}

          [Network]
          DHCP=${config.sops.placeholder."networks/mishima/bridge/dhcp"}
        '';
        mode = "0644";
        path = "/etc/systemd/network/10-lan-bridge.network";
      };

      "vmbr0.netdev" = {
        content = ''
          [NetDev]
          Kind=${config.sops.placeholder."networks/mishima/vm/kind"}
          Name=${config.sops.placeholder."networks/mishima/vm/name"}
        '';
        mode = "0644";
        path = "/etc/systemd/network/vmbr0.netdev";
      };
    };
  };
}
