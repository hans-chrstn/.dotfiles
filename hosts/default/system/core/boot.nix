{ inputs, outputs, lib, config, pkgs, ... }:

{
   boot = {
     supportedFilesystems = ["ntfs"];

    kernel.sysctl = {
      "vm.swappiness" = 60;  #default = 60

    };
    initrd = {
      kernelModules = ["i915"];
    };

    kernelParams = [
      "i915.force_probe=8a56"
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
        theme = pkgs.sleek-grub-theme;
      };
    };
    tmp.cleanOnBoot = true;
  }; 

}
