{ pkgs, ... }:

{
   boot = {
     supportedFilesystems = ["ntfs"];

    kernel.sysctl = {
      "vm.swappiness" = 60;  #default = 60
      "vm.nr_hugepages" = 0;

    };
    initrd = {
      kernelModules = [
        "i915"
      ];
      compressor = "xz";
    };

    kernelParams = [
      "i915.force_probe=8a56"
      "i915.enable_guc=2"
      "i915.enable_fbc=1"
      "i915.enable_psr=2"
      "1915.enable_gvt=0"
      "i915.fastboot=1"
      "i915.mitigations=off"
      "i915.modeset=1"
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "auto";
      efi.efiSysMountPoint = "/boot";
#      grub = {
#        enable = true;
#        devices = ["nodev"];
#        efiSupport = true;
#        useOSProber = true;
#        theme = pkgs.sleek-grub-theme;
#      };
    };
    tmp.cleanOnBoot = true;
  }; 


}
