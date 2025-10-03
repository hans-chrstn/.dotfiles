{ inputs, config, pkgs, ... }:
let
  # Base driver package: stable or beta
  video = config.boot.kernelPackages.nvidiaPackages.stable;

  # Conditionally apply fbc patch if available
  pkgAfterFbc = if builtins.hasAttr video.version pkgs.nvidia-patch-list.fbc
                then pkgs.nvidia-patch.patch-fbc video
                else video;

  # Conditionally apply nvenc patch if available
  finalPkg = if builtins.hasAttr video.version pkgs.nvidia-patch-list.nvenc
             then pkgs.nvidia-patch.patch-nvenc pkgAfterFbc
             else pkgAfterFbc;

in
{
  nixpkgs.overlays = [
    inputs.nvidia-patch.overlays.default
  ];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      open = true;
      nvidiaSettings = true;
      # package = config.boot.kernelPackages.nvidiaPackages.latest;
      package = finalPkg;
    };
  };
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
  hardware.graphics.extraPackages = [
    pkgs.nvidia-vaapi-driver
    pkgs.libvdpau-va-gl
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.sessionVariables = {
    MOZ_DISABLE_RDD_SANDBOX = "1";
    MOZ_DRM_DEVICE = "/dev/dri/renderD128";
    # LIBVA_DRIVER_NAME = "nvidia";
    # GBM_BACKEND = "nvidia-drm";
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
