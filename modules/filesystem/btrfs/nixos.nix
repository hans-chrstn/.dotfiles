{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.filesystems.btrfsRollback;
in {
  options.dotfiles.filesystems.btrfsRollback = {
    enable = lib.mkEnableOption "Enable the btrfs feature";
    device = lib.mkOption {
      type = lib.types.str;
      default = "/dev/disk/by-label/nixos";
      description = "Btrfs device containing the root subvolume";
    };
    retentionDays = lib.mkOption {
      type = lib.types.ints.positive;
      default = 30;
      description = "Days to retain old root subvolumes";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.initrd.systemd.services.btrfs-rollback = {
      description = "Rollback BTRFS root subvolume to a pristine state";
      wantedBy = ["initrd.target"];
      after = ["dev-disk-by\\x2dlabel-nixos.device"];
      requires = ["dev-disk-by\\x2dlabel-nixos.device"];
      before = ["sysroot.mount"];
      unitConfig.DefaultDependencies = "no";
      serviceConfig.Type = "oneshot";
      path = with pkgs; [
        btrfs-progs
        coreutils
        findutils
        util-linux
      ];

      script = ''
        set -euo pipefail

        mkdir -p /btrfs_tmp
        mount ${lib.escapeShellArg cfg.device} /btrfs_tmp
        trap 'umount /btrfs_tmp' EXIT

        test "$(findmnt -n -o SOURCE /btrfs_tmp)" = "${cfg.device}"

        if [[ -e /btrfs_tmp/root ]]; then
            mkdir -p /btrfs_tmp/old_roots
            timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
            mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
        fi

        delete_subvolume_recursively() {
            local child
            while IFS= read -r child; do
                delete_subvolume_recursively "/btrfs_tmp/$child"
            done < <(btrfs subvolume list -o "$1" | cut -f 9- -d ' ')
            btrfs subvolume delete "$1"
        }

        if [[ -d /btrfs_tmp/old_roots ]]; then
            while IFS= read -r -d "" old_root; do
                case "$old_root" in
                    /btrfs_tmp/old_roots/*) delete_subvolume_recursively "$old_root" ;;
                    *) exit 1 ;;
                esac
            done < <(find /btrfs_tmp/old_roots -mindepth 1 -maxdepth 1 -mtime +${toString cfg.retentionDays} -print0)
        fi

        btrfs subvolume create /btrfs_tmp/root
        umount /btrfs_tmp
        trap - EXIT
      '';
    };
  };
}
