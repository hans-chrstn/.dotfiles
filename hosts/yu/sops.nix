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
      "networks/yu/interface/private-key" = {};
      "networks/yu/interface/address" = {};
      "networks/yu/interface/dns" = {};
      "networks/yu/peer/public-key" = {};
      "networks/yu/peer/preshared-key" = {};
      "networks/yu/peer/allowed-ips" = {};
      "networks/yu/peer/endpoint" = {};
    };
    templates = {
      "unsecured" = {
        content = ''
          [Interface]
          PrivateKey = ${config.sops.placeholder."networks/yu/interface/private-key"}
          Address = ${config.sops.placeholder."networks/yu/interface/address"}
          DNS = ${config.sops.placeholder."networks/yu/interface/dns"}

          [Peer]
          PublicKey = ${config.sops.placeholder."networks/yu/peer/public-key"}
          PresharedKey = ${config.sops.placeholder."networks/yu/peer/preshared-key"}
          AllowedIPs = ${config.sops.placeholder."networks/yu/peer/allowed-ips"}
          Endpoint = ${config.sops.placeholder."networks/yu/peer/endpoint"}
          PersistentKeepalive = 25
        '';
        path = "/etc/wireguard/unsecured.conf";
      };
    };
  };
}
