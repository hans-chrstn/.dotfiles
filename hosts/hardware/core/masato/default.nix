{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostId = "fffafb21"; #temp just to test zfs

  nix = {
    settings = {
      cores = 4;
      max-jobs = 8;
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment.systemPackages = with pkgs; [ zfs ];

  boot = {
    supportedFilesystems = ["ntfs" "zfs"];
    blacklistedKernelModules = [ "ucsi_ccg" "typec_ucsi" "i2c_ccgx_ucsi" ];

    kernelModules = [
      "zfs"
    ];

    kernel.sysctl = {
      "vm.swappiness" = 60;  #default = 60
      "vm.nr_hugepages" = 0;

    };
    kernelParams = [
      "quiet"
      "splash"
      "nomodeset" # remove if using igpu
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

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
