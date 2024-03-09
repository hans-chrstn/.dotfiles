{ config, pkgs, lib, ... }:

{
  #performance
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };
  services.tlp = {
    enable = true; 
    settings = {
      INTEL_GPU_MIN_FREQ_ON_AC = 500;
      INTEL_GPU_MIN_FREQ_ON_BAT = 500;


    };
  };
  # for tlp to work
  services.power-profiles-daemon.enable = false;
}
