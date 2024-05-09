{ ... }:

{

  # REBUILD
  nix.settings = {
      cores = 4;
      max-jobs = 4;
  };


  # Microcodes for Intel
  hardware.cpu.intel.updateMicrocode = true;

  # Performance for Intel CPU's
	services = {
		fwupd =	{
			enable = true;
		};
		thermald = {
			enable = true;
		};
	};
  
  # REQ for my widgets
  services.upower = {
    enable = true;
  };


  # Performance
  powerManagement = {
    enable = true;
  };

  services.tlp = {
    enable = true; 
    settings = {
      #fix when overheating on power, not on battery
      #TLP_DEFAULT_MODE="BAT";
      TLP_PERSISTENT_DEFAULT=1;

      # ON ALL LAPTOPS
      NATCPI_ENABLE=1;

      # Kernel
      NMI_WATCHDOG=0;
      # FREQ GOV
      INTEL_GPU_MIN_FREQ_ON_AC=500;
      INTEL_GPU_MIN_FREQ_ON_BAT=500;
      INTEL_GPU_MAX_FREQ_ON_AC=900;
      INTEL_GPU_MAX_FREQ_ON_BAT=700;
      INTEL_GPU_BOOST_FREQ_ON_AC=900;
      INTEL_GPU_BOOST_FREQ_ON_BAT=700;
      # DELL IS UPTO 1100 

      # not available on DELL laptop
      #PLATFORM_PROFILE_ON_AC="performance"; # performance, low-power, balanced
      #PLATFORM_PROFILE_ON_BAT="performance"; # performance, low-power, balanced

      CPU_DRIVER_OPMODE_ON_AC="active"; # active or passive
      CPU_DRIVER_OPMODE_ON_BAT="active"; # active or passive

      CPU_SCALING_GOVERNOR_ON_AC="performance"; # performance or powersave
      CPU_SCALING_GOVERNOR_ON_BAT="performance"; # performance or powersave

      # DO NOT USE ON ACTIVE OPMODE. USE CPU_MIN/MAX_PERF INSTEAD
      #CPU_SCALING_MIN_FREQ_ON_AC=500;   # Set minimum frequency to 800 MHz on AC power
      #CPU_SCALING_MAX_FREQ_ON_AC=2900;  # Set maximum frequency to 3.20 GHz on AC power
      #CPU_SCALING_MIN_FREQ_ON_BAT=500; # Set minimum frequency to 500 MHz on battery power
      #CPU_SCALING_MAX_FREQ_ON_BAT=2900; # Set maximum frequency to 3.00 GHz on battery power
      

      CPU_ENERGY_PERF_POLICY_ON_AC="performance"; # performance, balance_performance, default, balance_power, power
      CPU_ENERGY_PERF_POLICY_ON_BAT="performance"; # performance, balance_performance, default, balance_power, power

      CPU_MIN_PERF_ON_AC=0; # based on 0 - 100%
      CPU_MAX_PERF_ON_AC=100; # based on 0 - 100%
      CPU_MIN_PERF_ON_BAT=0; # based on 0 - 100%
      CPU_MAX_PERF_ON_BAT=80; # based on 0 - 100%

      # WIFI powermanagement  
      WIFI_PWR_ON_AC="off";
      WIFI_PWR_ON_BAT="off";
      # Wake on lan (WOL) 
      WOL_DISABLE="N"; # Y or N


      # TO HELL WITH BOOST
      CPU_BOOST_ON_AC=0; # 0 or 1 
      CPU_BOOST_ON_BAT=0; # 0 or 1

      # power management for PCIe devices
      RUNTIME_PM_ON_AC="on"; # on disables, auto enables
      RUNTIME_PM_ON_BAT="auto"; # on disables, auto enables

      # PCIe ASPM
      PCIE_ASPM_ON_AC="performance"; # default, performance, powersave, powersupersave
      PCIE_ASPM_ON_BAT="performance";

      # MUST BE ON ACTIVE MODE TO ENABLE
      CPU_HWP_DYN_BOOST_ON_AC=1; # 0 or 1
      CPU_HWP_DYN_BOOST_ON_BAT=1; # 0 or 1

      # Save long term battery health (NOT SUPPORTED ON DELL)
      #START_CHARGE_THRESH_BAT0=40;
      #STOP_CHARGE_THRESH_BAT0=80;

      # usb autosuspend 
      USB_AUTOSUSPEND=1;

      # workaround if suspended usb devices disturb the shutdown process
      USB_AUTOSUSPEND_DISABLE_ON_SHUTDOWN=1;

      # denies autosuspend feature on devices below
      USB_DENYLIST="30fa:0400 0cf3:e009"; # my mouse ofc


    };
  };
  # For TLP to work, Disable.
  services.power-profiles-daemon.enable = false;


}
