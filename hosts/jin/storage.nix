{
  fileSystems."/mnt/games" = {
    device = "/dev/disk/by-uuid/d4adaace-47ab-4cf4-b44f-973b43b02de1";
    fsType = "ext4";
    options = ["noatime"];
  };

  boot.initrd.services.lvm.enable = true;
}
