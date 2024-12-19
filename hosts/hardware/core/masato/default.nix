{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;
  nix = {
    settings = {
      cores = 4;
      max-jobs = 4;
      auto-optimise-store = true;
    };
    
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  boot = {
    kernel.sysctl = {
      "vm.nr_hugepages" = 0;
    };
    kernelParams = [
      "quiet"
      "splash"
      "nomodeset"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "hpsa.hpsa_allow_any=1"
      "hpsa.hpsa_simple_mode=1"
    ];
    loader.grub = {
      device = "/dev/sda";
      enable = true;
    };
    tmp.cleanOnBoot = true;
  };
}
