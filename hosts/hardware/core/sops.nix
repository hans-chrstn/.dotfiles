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
      "networks/mishima/lan-bridge/bridge" = {};
      "networks/mishima/lan-bridge/address" = {};
      "networks/mishima/lan-bridge/gateway" = {};
      "networks/mishima/lan-bridge/interface" = {};
    };
    templates = {
      # NETWORKS
      "address".content = ''
        ${config.sops.placeholder."networks/mishima/lan-bridge/address"}
      '';
      "gateway".content = ''
        ${config.sops.placeholder."networks/mishima/lan-bridge/gateway"}
      '';
      "interface".content = ''
        ${config.sops.placeholder."networks/mishima/lan-bridge/interface"}
      '';
      "bridge".content = ''
        ${config.sops.placeholder."networks/mishima/lan-bridge/bridge"}
      '';
    };
  };
}
