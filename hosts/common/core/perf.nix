{ ... }:

{

  # REBUILD
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
