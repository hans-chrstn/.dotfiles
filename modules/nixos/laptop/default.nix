{
  lib,
  config,
  ...
}: let
  cfg = config.mod.hardware.laptop;
in {
  options.mod.hardware.laptop = {
    enable = lib.mkEnableOption "Enable the laptop feature";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      kernelModules = [
        "acpi_call"
      ];
      extraModulePackages = with config.boot.kernelPackages; [acpi_call];
    };
  };
}
