{ pkgs, lib, ... }:
{
  services.xserver.videoDrivers = [ "modesetting" ];
  # services.xserver.videoDrivers = [ "intel" ];
  # services.xserver.deviceSection = ''
  #   Option "DRI" "2"
  #   Option "TearFree" "true"
  # '';

  hardware.graphics = lib.mkForce {
    extraPackages = with pkgs; [ intel-media-driver intel-ocl intel-vaapi-driver vpl-gpu-rt];
  };

  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };
}
