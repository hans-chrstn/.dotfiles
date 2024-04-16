{ pkgs, 
  inputs, 
  ... 
}:
let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
        microcodeIntel
        libva
        vaapiVdpau
        libvdpau-va-gl
        pkgs-unstable.mesa.drivers
      ];
      extraPackages32 = [
        pkgs.pkgsi686Linux.vaapiVdpau
        pkgs.pkgsi686Linux.libvdpau-va-gl
        pkgs-unstable.pkgs.pkgsi686Linux.mesa.drivers
      ];
    };
  };

}
