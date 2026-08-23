{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.dotfiles.hardware.amd;
in {
  options.dotfiles.hardware.amd = {
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
      "amdgpu.ppfeaturemask=0xfff7ffff"
    ];

    hardware.amdgpu.initrd.enable = true;
    hardware.amdgpu.opencl.enable = true;
    services.lact.enable = true;
    hardware.amdgpu.overdrive.enable = true;
    environment.systemPackages = with pkgs; [amdgpu_top];

    services.xserver.videoDrivers = lib.mkIf cfg.enableGpu ["amdgpu"];
    boot.initrd.kernelModules = lib.mkIf cfg.enableGpu ["amdgpu"];
  };
}
