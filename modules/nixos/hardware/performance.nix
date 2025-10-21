{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.mod.performance;
in {
  options = {
    mod.performance.enable = lib.mkEnableOption "Configure power management";
    mod.performance.performanceMode = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable performance mode";
    };
  };

  config = lib.mkIf cfg.enable {
    services.upower.enable = true;

    powerManagement = {
      enable = true;
      cpuFreqGovernor = lib.mkIf cfg.performanceMode {
        lib.if cfg.performanceMode == lib.types.bool then
          
        else
      };
    };
  };
}
