{
  lib,
  config,
  ...
}: let
  cfg = config.mod.netfs;
in {
  options.mod.netfs = {
    enableNfs = lib.mkEnableOption "Enable the nfs feature";
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
