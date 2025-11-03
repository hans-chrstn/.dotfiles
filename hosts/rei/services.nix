{
  config,
  pkgs,
  ...
}: {
  systemd.services.wol-enable = {
    description = "Enable Wake-on-LAN";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
      EnvironmentFile = [config.sops.templates."wol-interface".path];
    };

    script = ''
      ${pkgs.ethtool}/bin/ethtool -s $INTERFACE_NAME wol g
    '';
  };
}
