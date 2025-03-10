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
      "networks/wg0/port" = {};
      "networks/wg0/server/public" = {};
      "networks/wg0/server/presharedkey" = {};
      "networks/wg0/server/ip" = {};
      "networks/wg0/client/public" = {};
      "networks/wg0/client/private" = {};
      "networks/wg0/client/address" = {};
    };
    templates = {
      "wg0.conf" = {
        content = ''
          [Interface]
          Address = ${config.sops.placeholder."networks/wg0/client/address"}
          PrivateKey = ${config.sops.placeholder."networks/wg0/client/private"}
          DNS = 1.1.1.1
          MTU = 1420

          [Peer]
          PublicKey = ${config.sops.placeholder."networks/wg0/server/public"}
          PresharedKey = ${config.sops.placeholder."networks/wg0/server/presharedkey"}
          AllowedIPs = 0.0.0.0/0
          Endpoint = ${config.sops.placeholder."networks/wg0/server/ip"}:${config.sops.placeholder."networks/wg0/port"}
          PersistentKeepalive = 25
        '';
        path = "/etc/wireguard/wg0.conf";
      };
    };
  };
}
