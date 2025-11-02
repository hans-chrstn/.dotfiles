{
  pkgs,
  lib,
  config,
  modules,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./sops.nix
    modules.amd
    modules.audio
    modules.nvidia
    modules.dbus
    modules.nix-ld
    modules.netfs
    modules.greetd
    modules.ssh
    modules.opengl
    modules.virtualize
    modules.zfs
  ];

  services.openiscsi = {
    name = "iqn.2025-10.org.homelab-nix:nixos-server-1";
    enable = true;
    extraConfig = ''
      node.session.auth.authmethod = CHAP
      node.startup = automatic
    '';
  };

  systemd.services.iscsi-setup = {
    description = "Setup ISCSI targets";
    after = ["network-online.target" "iscsid.service" "sops-nix.service"];
    wants = ["network-online.target"];
    requires = ["iscsid.service" "sops-nix.service"];
    before = ["zfs-import.service"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      EnvironmentFile = [
        config.sops.templates."iscsi-config".path
      ];
    };

    script = ''
      until ${pkgs.iputils}/bin/ping -c 1 $TARGET_IP > /dev/null 2>&1; do
        echo "Waiting for ISCSI target at $TARGET_IP..."
      done

      echo "Discovering ISCSI targets..."
      ${pkgs.openiscsi}/bin/iscsiadm -m discovery -t sendtargets -p $TARGET_IP

      echo "Logging into iSCSI target $TARGET_IQN..."
      ${pkgs.openiscsi}/bin/iscsiadm -m node -T $TARGET_IQN --login || true

      ${pkgs.openiscsi}/bin/iscsiadm -m node -T $TARGET_IQN --op update -n node.startup -v automatic || true

      echo "Waiting for iSCSI device..."
      sleep 2
    '';
  };

  systemd.services.zfs-import-data = {
    description = "Import ZFS pool";
    after = ["iscsi-setup.service" "zfs-import.target"];
    requires = ["iscsi-setup.service"];
    before = ["docker.service"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      EnvironmentFile = [config.sops.templates."iscsi-config".path];
    };

    script = ''
      echo "Importing ZFS pool $POOL_NAME..."
      ${config.boot.zfs.package}/bin/zpool import -N $POOL_NAME || true
      ${config.boot.zfs.package}/bin/zpool import $POOL_NAME
      echo "ZFS pool $POOL_NAME imported successfully"
    '';
  };

  systemd.services.docker = {
    after = ["zfs-import-data.service"];
    requires = ["zfs-import-data.service"];
  };

  mod = {
    virtualize = {
      docker = {
        enable = true;
        enableNvidiaSupport = true;
        extraOptions = ''
          --data-root="/data/docker/root"
        '';
      };
      proxmox = {
        enable = true;
        ip = "192.168.110.3";
      };
    };
    netfs = {
      iscsi.client = {
        enable = true;
        extraConfig = ''
          node.session.auth.authmethod = CHAP
        '';
        initiatorName = "iqn.2025-10.org.homelab-nix:${config.networking.hostName}";
      };
    };
    hardware = {
      amd = {
        enable = true;
        enableGpu = true;
      };
      audio.enable = true;
      nvidia.enable = true;
      opengl.enable = true;
    };
    programs = {
      dbus.enable = true;
      nix-ld.enable = true;
    };
    services = {
      zfs = {
        enable = true;
        id = "8565dd80";
      };
      greetd.enable = true;
      ssh = {
        enable = true;
        allowedIps = [
          "192.168.110.2/32"
          "192.168.110.3/32"
          "192.168.110.4/32"
        ];
      };
    };
  };

  programs.zsh.enable = true;

  users.mutableUsers = false;
  users.users = {
    "makoto" = {
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      isNormalUser = true;
      description = "Primary user for makoto";
      extraGroups = [
        "wheel"
        "docker"
        "podman"
      ];
      shell = pkgs.zsh;
    };
    root = {
      hashedPasswordFile = config.sops.secrets."users/jin/password".path;
      isSystemUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.zsh;
    };
  };

  systemd.network.enable = true;
  networking = {
    hostName = "nixos-server-1";
    networkmanager.enable = lib.mkForce false;
    useDHCP = lib.mkForce false;
    firewall = {
      allowedTCPPorts = [];
      allowedUDPPorts = [];
      allowedTCPPortRanges = [];
      allowedUDPPortRanges = [];
    };
  };
}
