{ pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libva
      vaapiVdpau
      libvdpau-va-gl
    ];
    
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vaapiVdpau
      libvdpau-va-gl

    ];

  };

}
