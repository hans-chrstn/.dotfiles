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
    };
    templates = {
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
