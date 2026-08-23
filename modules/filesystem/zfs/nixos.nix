{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.dotfiles.filesystems.zfs;
in {
  options.dotfiles.filesystems.zfs = {
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
    boot.zfs.extraPools = cfg.importPools;
    services.zfs = {
      autoScrub = {
        enable = true;
        pools = cfg.importPools;
      };
      autoSnapshot = {
        enable = true;
        frequent = 0; # Disable 15-minute snapshots if you don't want them
        hourly = 0; # Disable hourly snapshots
        daily = 0; # Disable daily snapshots
        weekly = 4; # Keep the last 4 weekly snapshots
        monthly = 0; # Disable monthly snapshots
      };
    };

    networking.hostId = cfg.id;

    environment.systemPackages = with pkgs; [zfs];
    boot.supportedFilesystems = ["zfs"];
    boot.kernelModules = ["zfs"];
  };
}
