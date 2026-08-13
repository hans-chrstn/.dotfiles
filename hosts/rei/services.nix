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
  systemd.services.target-restore = {
    description = "Restore iSCSI target configuration";
    after = ["configfs.service" "iscsi_target.service" "zfs-import-tank.service" "zfs-volumes.target"];
    wants = ["zfs-import-tank.service" "zfs-volumes.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      echo "Waiting for ZFS zvol /dev/zvol/tank/data..."
      for i in {1..30}; do
        if [ -b /dev/zvol/tank/data ]; then
          break
        fi
        sleep 1
      done

      if [ ! -b /dev/zvol/tank/data ]; then
        echo "Error: ZFS zvol /dev/zvol/tank/data did not appear in time."
        exit 1
      fi

      if [ -f /etc/target/saveconfig.json ]; then
        ${pkgs.targetcli-fb}/bin/targetcli clearconfig confirm=true || true
        ${pkgs.targetcli-fb}/bin/targetcli restoreconfig /etc/target/saveconfig.json
        echo "iSCSI configuration restored successfully."
      else
        echo "Error: /etc/target/saveconfig.json not found."
        exit 1
      fi
    '';
  };
}
