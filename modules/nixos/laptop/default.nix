{
  lib,
  config,
  ...
}: let
  cfg = config.mod.hardware.laptop;
in {
  options.mod.hardware.laptop = {
    enable = lib.mkEnableOption "Enable the laptop feature";
    powerOptions = lib.mkOption {
      type = lib.types.enum ["performance" "powersave"];
      default = "powersave";
      description = "Select either performance | powersave";
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      kernelModules = [
        "acpi_call"
      ];
      extraModulePackages = with config.boot.kernelPackages; [acpi_call];
    };

    services.power-profiles-daemon.enable = true;
    powerManagement = {
      enable = true;
      cpuFreqGovernor = if cfg.powerOptions == "powersave" then
        "powersave"
      else
        "performance";
    };
  };
}
