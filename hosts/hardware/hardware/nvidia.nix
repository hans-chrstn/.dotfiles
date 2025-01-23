{ config, ... }:
{
  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia-container-toolkit.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GLX_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    __GL_THREADED_OPTIMIZATIONS = "0";
    NVD_BACKEND = "direct";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    DISABLE_QT5_COMPAT = "0";
    # WLR_NO_HARDWARE_CURSORS = "1";
    # WLR_DRM_NO_ATOMIC = "1";
    #LIBSEAT_BACKEND = "logind";
    #WLR_DRM_DEVICES = "/dev/dri/card1";
    #WLR_RENDERER = "vulkan";
  };
}
