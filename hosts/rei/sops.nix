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
      "networks/rei/main/name" = {};
      "networks/rei/main/dhcp" = {};
      "networks/rei/vm/kind" = {};
      "networks/rei/vm/name" = {};
      "networks/rei/bridge/name" = {};
      "networks/rei/bridge/dhcp" = {};
      "networks/rei/bridge/mad" = {};
    };
    templates = {
      "10-lan.network" = {
        content = ''
          [Match]
          Name=${config.sops.placeholder."networks/rei/main/name"}

          [Link]
          RequiredForOnline=routable
          MACAddress=${config.sops.placeholder."networks/rei/bridge/mad"}

          [Network]
          DHCP=${config.sops.placeholder."networks/rei/main/dhcp"}
        '';
        mode = "0644";
        path = "/etc/systemd/network/10-lan.network";
      };
    };
  };
}
