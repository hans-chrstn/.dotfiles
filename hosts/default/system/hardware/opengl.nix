{ pkgs, inputs, ... }:
let
  pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  hardware = {
#    cpu.intel.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
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
