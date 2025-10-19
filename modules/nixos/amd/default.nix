{ lib, config, ... }:
let
  cfg = config.mod.hardware.amd;
in
{
  options.mod.hardware.amd = {
    enable = lib.mkEnableOption "Enable the amd feature";
    enableGpu = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable AMD gpu kernel modules";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.kernelParams = [
      "amd_iommu=on"
      "amdgpu.sg_display=0"
    ];

    services.xserver.videoDrivers = lib.mkIf cfg.enableGpu [ "amdgpu" ];
    boot.initrd.kernelModules = lib.mkIf cfg.enableGpu [ "amdgpu" ];
  };
}
