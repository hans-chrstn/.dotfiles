{
  lib,
  config,
  ...
}: let
  cfg = config.mod.netfs;
in {
  options.mod.netfs = {
    enableNfs = lib.mkEnableOption "Enable the nfs feature";
    enableIscsi = lib.mkEnableOption "Enable the iscsi feature";
    smb.enable = lib.mkEnableOption "Enable the smb feature";
    smb.path = lib.mkOption {
      type = lib.types.string;
      default = "/srv/samba/private";
      description = "Path to samba folder";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enableNfs {
      services.nfs = {
        enable = true;
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
    (lib.mkIf cfg.enableIscsi {
      services.openiscsi = {
        enable = true;
        extraConfig = ''
          node.startup = automatic
          node.session.initial_login_retry_max = 8
          node.session.timeo.replacement_timeout = 120
          node.conn[0].timeo.login_timeout = 15
          node.conn[0].timeo.logout_timeout = 15
          node.conn[0].timeo.noop_out_interval = 5
          node.conn[0].timeo.noop_out_timeout = 5
          node.session.cmds_max = 128
          node.session.queue_depth = 32
          node.session.iscsi.ImmediateData = Yes
          node.session.iscsi.InitialR2T = No
          node.session.iscsi.FirstBurstLength = 262144
          node.session.iscsi.MaxBurstLength = 16776192
          node.conn[0].iscsi.MaxRecvDataSegmentLength = 262144
          node.conn[0].iscsi.MaxXmitDataSegmentLength = 0
          node.conn[0].iscsi.HeaderDigest = CRC32C,None
          node.conn[0].iscsi.DataDigest = CRC32C,None
          node.session.nr_sessions = 1
          node.session.iscsi.FastAbort = Yes
          node.session.scan = auto
        '';
      };
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
