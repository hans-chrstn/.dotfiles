{
  config,
  pkgs,
  ...
}:
{
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
    wants = [ "network-online.target" ];
    requires = [ "iscsid.service" ];
    before = [
      "docker.service"
      "umount.target"
    ];
    wantedBy = [ "multi-user.target" ];
    conflicts = [ "umount.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      TimeoutStartSec = "600s";
      TimeoutStopSec = "60s";
      EnvironmentFile = [ config.sops.templates."iscsi-config".path ];
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
      timeout 30 ${pkgs.systemd}/bin/systemctl stop docker.service docker.socket 2>/dev/null || {
        echo "Docker didn't stop cleanly, killing..."
        ${pkgs.systemd}/bin/systemctl kill docker.service
        ${pkgs.systemd}/bin/systemctl kill docker.socket
        sleep 2
      }

      ${pkgs.psmisc}/bin/fuser -km /data 2>/dev/null || true
      sleep 1

      ${config.boot.zfs.package}/bin/zfs unmount -a 2>/dev/null || true
      ${config.boot.zfs.package}/bin/zpool export -f $POOL_NAME 2>/dev/null || true

      ${pkgs.openiscsi}/bin/iscsiadm -m node -T $TARGET_IQN --logout 2>/dev/null || true

      echo "Shutdown complete"
    '';
  };

  systemd.services.iscsi-watchdog = {
    description = "Monitor iSCSI connection and recover from failures";
    after = [ "iscsi-zfs-manager.service" ];
    requires = [ "iscsi-zfs-manager.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = "10s";
      EnvironmentFile = [ config.sops.templates."iscsi-config".path ];
    };

    script = ''
      echo "iSCSI watchdog started, monitoring connection..."

      FAILURE_COUNT=0

      while true; do
        sleep 10
        
        if ! ${pkgs.openiscsi}/bin/iscsiadm -m session 2>/dev/null | grep -q "$TARGET_IQN"; then
          echo "WARNING: iSCSI session lost!"
          FAILURE_COUNT=$((FAILURE_COUNT + 1))
          
          if [ $FAILURE_COUNT -ge 3 ]; then
            echo "iSCSI connection lost, initiating emergency cleanup..."
            
            ${pkgs.systemd}/bin/systemctl kill -s SIGKILL docker.service 2>/dev/null || true
            ${pkgs.systemd}/bin/systemctl kill -s SIGKILL docker.socket 2>/dev/null || true
            
            ${pkgs.psmisc}/bin/fuser -km -9 /data 2>/dev/null || true
            sleep 2
            
            ${config.boot.zfs.package}/bin/zpool export -f $POOL_NAME 2>/dev/null || true
            
            ${pkgs.systemd}/bin/systemctl stop iscsi-zfs-manager.service
            exit 0
          fi
        else
          if [ $FAILURE_COUNT -gt 0 ]; then
            echo "iSCSI connection restored"
            FAILURE_COUNT=0
          fi
        fi
      done
    '';
  };

  systemd.services.docker = {
    after = [ "iscsi-zfs-manager.service" ];
    requires = [ "iscsi-zfs-manager.service" ];

    serviceConfig = {
      TimeoutStopSec = "30s";
      KillMode = "mixed";
      KillSignal = "SIGTERM";
    };
  };

  systemd.services.wol-enable = {
    description = "Enable Wake-on-LAN";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      EnvironmentFile = [ config.sops.templates."wol-interface".path ];
    };

    script = ''
      ${pkgs.ethtool}/bin/ethtool -s $INTERFACE_NAME wol g
    '';
  };
}
