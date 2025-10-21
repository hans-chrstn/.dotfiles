{
  lib,
  config,
  ...
}: let
  cfg = config.mod.hardware.intel;
in {
  options.mod.hardware.intel = {
    enable = lib.mkEnableOption "Enable the intel feature";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      initrd.kernelModules = "i915";
      kernelParams = [
        "i915.force_probe=8a56"
        "i915.enable_guc=2"
        "i915.enable_fbc=1"
        "i915.enable_psr=2"
        "1915.enable_gvt=0"
        "i915.fastboot=1"
        "i915.mitigations=off"
        "i915.modeset=1"
      ];
    };
  };
}
