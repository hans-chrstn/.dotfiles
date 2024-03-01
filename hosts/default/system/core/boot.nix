{ inputs, outputs, lib, config, pkgs, ... }:

{
   boot = {
    initrd = {
      kernelModules = ["i915"];
    };
    kernelParams = ["i915.force_probe=8a56"];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
      };
    };
  }; 

}
