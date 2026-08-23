{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.filesystems.network;
in {
  options.dotfiles.filesystems.network = {
    nfs.enable = lib.mkEnableOption "NFS server";
    iscsi.client = {
      enable = lib.mkEnableOption "Open-iSCSI client";
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
    iscsi.server = {
      enable = lib.mkEnableOption "targetcli iSCSI server";
      allowedIps = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "Source CIDRs allowed to connect to the iSCSI target";
      };
    };
    smb.enable = lib.mkEnableOption "Samba server";
    smb.openFirewall = lib.mkEnableOption "automatic Samba firewall rules";
    smb.path = lib.mkOption {
      type = lib.types.str;
      default = "/srv/samba/private";
      description = "Path to samba folder";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.nfs.enable {
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
      networking.nftables.enable = true;
      networking.firewall.extraInputRules = lib.mkIf (cfg.iscsi.server.allowedIps != []) ''
        ip saddr { ${lib.concatStringsSep ", " cfg.iscsi.server.allowedIps} } tcp dport 3260 accept
      '';
    })

    (lib.mkIf cfg.smb.enable {
      services.samba = {
        enable = true;
        openFirewall = cfg.smb.openFirewall;
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
        openFirewall = cfg.smb.openFirewall;
      };
    })
  ];
}
