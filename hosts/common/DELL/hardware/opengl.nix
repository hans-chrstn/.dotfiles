{ pkgs, 
  inputs, 
  ... 
}:
{
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        microcodeIntel
        libva
        vaapiVdpau
        libvdpau-va-gl
        mesa.drivers
        mesa
        libdrm
      ];
      extraPackages32 = [
        pkgs.pkgsi686Linux.vaapiVdpau
        pkgs.pkgsi686Linux.libvdpau-va-gl
        pkgs.pkgsi686Linux.mesa.drivers
        pkgs.pkgsi686Linux.mesa
      ];
    };
  };

}
