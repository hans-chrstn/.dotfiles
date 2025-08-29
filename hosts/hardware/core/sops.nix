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
      "networks/pia" = {};
      "networks/pia-config" = {};
      "networks/wg-laptop/interface/private-key" = {};
      "networks/wg-laptop/interface/address" = {};
      "networks/wg-laptop/interface/dns" = {};
      "networks/wg-laptop/peer/public-key" = {};
      "networks/wg-laptop/peer/preshared-key" = {};
      "networks/wg-laptop/peer/allowed-ips" = {};
      "networks/wg-laptop/peer/endpoint" = {};
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
      "auth" = {
        content = ''
          ${config.sops.placeholder."networks/pia"}
        '';
        path = "/etc/pia/auth";
      };
      "config" = {
        content = ''
          ${config.sops.placeholder."networks/pia-config"}
        '';
        path = "/etc/pia/config";
      };
    };
  };
}
