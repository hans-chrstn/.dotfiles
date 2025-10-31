{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.mod.netfs;
in {
  options.mod.netfs = {
    enableNfs = lib.mkEnableOption "Enable the nfs feature";
    iscsi.client = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable Open-iscsi";
      };
      extraConfig = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "String concatenated extra config for the client";
      };
      initiatorName = lib.mkOption {
        type = lib.types.str;
        description = "The unique IQN for this iSCSI client (from /etc/iscsi/initiatorname.iscsi).";
      };
    };
    iscsi.server.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable targetcli";
    };
    smb.enable = lib.mkEnableOption "Enable the smb feature";
    smb.path = lib.mkOption {
      type = lib.types.str;
      default = "/srv/samba/private";
      description = "Path to samba folder";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enableNfs {
      services.nfs.server.enable = true;
      services.nfs = {
        settings = {
          nfsd = {
            threads = 8;
            tcp = true;
            udp = false;
            vers3 = false;
            vers4 = true;
            "vers4.0" = true;
            "vers4.1" = true;
            "vers4.2" = true;
          };
          mountd = {
            manage-gids = true;
            reverse-lookup = false;
            threads = 4;
          };
        };
      };
    })
    (lib.mkIf cfg.iscsi.client.enable {
      services.openiscsi = {
        enable = true;
        name = cfg.iscsi.client.initiatorName;
        extraConfig = cfg.iscsi.client.extraConfig;
      };
    })

    (lib.mkIf cfg.iscsi.server.enable {
      environment.systemPackages = [pkgs.targetcli-fb];

      boot.kernelModules = [
        "configfs"
        "target_core_mod"
        "iscsi_target_mod"
      ];

      systemd.services.iscsi-target = {
        enable = true;
        after = [
          "network.target"
          "local-fs.target"
        ];
        requires = ["sys-kernel-config.mount"];
        wantedBy = ["multi-user.target"];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = [
            "${lib.getExe pkgs.python3Packages.rtslib-fb}"
            "restore"
          ];
          ExecStop = [
            "${lib.getExe pkgs.python3Packages.rtslib-fb}"
            "clear"
            ""
          ];
          RemainAfterExit = "yes";
        };
      };

      systemd.tmpfiles.rules = [
        "d /etc/target 0700 root root - -"
      ];
    })
    (lib.mkIf cfg.smb.enable {
      services.samba = {
        enable = true;
        openFirewall = true;
        settings = {
          global = {
            workgroup = "WORKGROUP";
            "server string" = "NixOS Samba Server";
            "netbios name" = "nixos-samba";
            security = "user";
            "map to guest" = "bad user";
            "guest account" = "nobody";
            "log file" = "/var/log/samba/log.%m";
            "max log size" = 50;
          };
          "private" = {
            path = cfg.smb.path;
            comment = "Secure private data";
            browseable = "yes";
            "valid users" = "@smbusers";
            "read only" = "no";
            "create mask" = "0660";
            "directory mask" = "0771";
          };
        };
      };
      services.samba-wsdd = {
        enable = true;
        openFirewall = true;
      };
    })
  ];
}
