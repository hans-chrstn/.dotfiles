{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    settings = {
      cores = 12;
      max-jobs = 24;
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  boot = {
    supportedFilesystems = ["ntfs"];

    kernelModules = [
    ];

    kernel.sysctl = {
      "vm.swappiness" = 60;  #default = 60
      "vm.nr_hugepages" = 0;

    };
    kernelParams = [
      "quiet"
      "splash"
      # "nomodeset"
      "amdgpu.sg_display=0"
      "nvidia-drm.fbdev=1"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    #kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "max";
      systemd-boot.editor = false;
      timeout = 4;
      efi.efiSysMountPoint = "/boot";
    };
    tmp.cleanOnBoot = true;
  };

}
