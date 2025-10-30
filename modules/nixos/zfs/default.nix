{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.mod.services.zfs;
in {
  options.mod.services.zfs = {
    enable = lib.mkEnableOption "Enable the zfs feature";
    id = lib.mkOption {
      type = lib.types.str;
      default = "zfs-host-id";
      description = "ID to have ZFS recognize you";
    };
    importPools = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of string that will be imported to ZFS";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.zfs = {
      extraPools = cfg.importPools;
    };

    services.zfs = {
      autoScrub = {
        enable = true;
        pools = cfg.importPools;
      };
      autoSnapshot = {
        enable = true;
      };
    };

    networking.hostId = cfg.id;

    environment.systemPackages = with pkgs; [zfs];
    boot.supportedFilesystems = ["zfs"];
    boot.kernelModules = ["zfs"];
  };
}
