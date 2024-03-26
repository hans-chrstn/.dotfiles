{ config, pkgs, lib, ... }:

{
  #performance
  powerManagement = {
    enable = true;
#    cpuFreqGovernor = "performance";
#    cpuFreqGovernor = "ondemand";
    cpuFreqGovernor = "powersave";
#    powertop.enable = true;
  };

  services.upower = {
    enable = true;
  };
  services.tlp = {
    enable = true; 
    settings = {
      #fix when overheating on power, not on battery
      TLP_DEFAULT_MODE="BAT";
      TLP_PERSISTENT_DEFAULT=1;

      INTEL_GPU_MIN_FREQ_ON_AC=500;
      INTEL_GPU_MIN_FREQ_ON_BAT=500;
      INTEL_GPU_MAX_FREQ_ON_AC=900;
      INTEL_GPU_MAX_FREQ_ON_BAT=700;
      INTEL_GPU_BOOST_FREQ_ON_AC=900;
      INTEL_GPU_BOOST_FREQ_ON_BAT=900;

      PLATFORM_PROFILE_ON_AC="performance";
      PLATFORM_PROFILE_ON_BAT="powersave";

      CPU_DRIVER_OPMODE_ON_AC="active";
      CPU_DRIVER_OPMODE_ON_BAT="active";

      CPU_SCALING_GOVERNOR_ON_AC="performance";
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC="performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT="default";

      CPU_MIN_PERF_ON_AC=0;
      CPU_MAX_PERF_ON_AC=100;
      CPU_MIN_PERF_ON_BAT=0;
      CPU_MAX_PERF_ON_BAT=70;

      #save long term battery health
      START_CHARGE_THRESH_BAT0=40;
      STOP_CHARGE_THRESH_BAT0=80;


    };
  };
  # for tlp to work
  services.power-profiles-daemon.enable = false;


# REPLACEMENT FOR TLP
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
       governor = "powersave";
       turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };
}
