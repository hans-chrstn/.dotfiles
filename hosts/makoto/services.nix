{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    lsof
    psmisc
  ];

  systemd.services.iscsi-zfs-manager = {
    description = "Manage iSCSI connection and ZFS pool";
    after = [
      "network-online.target"
      "iscsid.service"
    ];
    wants = ["network-online.target"];
    requires = ["iscsid.service"];
    before = [
      "docker.service"
      "umount.target"
    ];
    wantedBy = ["multi-user.target"];
    conflicts = ["umount.target"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      TimeoutStartSec = "600s";
      TimeoutStopSec = "60s";
      EnvironmentFile = [config.sops.templates."iscsi-config".path];
    };

    script = ''
      if ${pkgs.openiscsi}/bin/iscsiadm -m session 2>/dev/null | grep -q "$TARGET_IQN"; then
        echo "Already logged into iSCSI"
      else
        if ! ${pkgs.iputils}/bin/ping -c 1 -W 2 $TARGET_IP >/dev/null 2>&1; then
          echo "Waking server-2..."
          ${pkgs.wol}/bin/wol $TARGET_MAC || true

          for i in {1..150}; do
            if ${pkgs.iputils}/bin/ping -c 1 -W 2 $TARGET_IP >/dev/null 2>&1; then
              break
            fi
            sleep 2
          done
        fi

        for i in {1..60}; do
          if ${pkgs.netcat}/bin/nc -z -w 2 $TARGET_IP 3260 >/dev/null 2>&1; then
            break
          fi
          sleep 2
        done

        ${pkgs.openiscsi}/bin/iscsiadm -m discovery -t sendtargets -p $TARGET_IP
        ${pkgs.openiscsi}/bin/iscsiadm -m node -T $TARGET_IQN --login
        ${pkgs.openiscsi}/bin/iscsiadm -m node -T $TARGET_IQN --op update -n node.startup -v automatic || true

        echo "Waiting for udev to settle..."
        ${pkgs.systemd}/bin/udevadm settle --timeout=30
      fi

      if ! ${config.boot.zfs.package}/bin/zpool list -H -o name 2>/dev/null | grep -q "^$POOL_NAME$"; then
        echo "Importing ZFS pool..."
        ${config.boot.zfs.package}/bin/zpool import $POOL_NAME
      else
        echo "Pool already imported"
      fi

      ${config.boot.zfs.package}/bin/zfs mount -a || true
      echo "Startup complete"
    '';

    preStop = ''
      ${pkgs.systemd}/bin/systemctl stop docker.service docker.socket 2>/dev/null || true

      ${pkgs.psmisc}/bin/fuser -km /data 2>/dev/null || true

      ${config.boot.zfs.package}/bin/zfs unmount -a 2>/dev/null || true
      ${config.boot.zfs.package}/bin/zpool export -f $POOL_NAME 2>/dev/null || true

      ${pkgs.openiscsi}/bin/iscsiadm -m node -T $TARGET_IQN --logout 2>/dev/null || true

      echo "Shutdown complete"
    '';
  };

  systemd.services.docker = {
    after = ["iscsi-zfs-manager.service"];
    requires = ["iscsi-zfs-manager.service"];
  };

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
