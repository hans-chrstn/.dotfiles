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
      INTEL_GPU_MAX_FREQ_ON_AC=900;
      INTEL_GPU_MAX_FREQ_ON_BAT=700;
      INTEL_GPU_BOOST_FREQ_ON_AC=900;
      INTEL_GPU_BOOST_FREQ_ON_BAT=900;

      PLATFORM_PROFILE_ON_AC="performance";
      PLATFORM_PROFILE_ON_BAT="balanced";

      CPU_DRIVER_OPMODE_ON_AC="active";
      CPU_DRIVER_OPMODE_ON_BAT="active";

      CPU_SCALING_GOVERNOR_ON_AC="performance";
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC="performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT="default";


    };
  };
  # for tlp to work
  services.power-profiles-daemon.enable = false;
}
