{ ... }:

{

  # REQ for my widgets
  services.upower = {
    enable = true;
  };

  # Performance
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  # For TLP to work, Disable.
  services.power-profiles-daemon.enable = true;


}
