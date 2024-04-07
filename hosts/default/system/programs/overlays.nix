{ inputs, ... }:
{
  /*
    OVERLAYS ARE SOMETHING THAT GOES ABOVE A PACKAGE
    IN SUMMARY, THIS OVERLAYS GO ABOVE THE PACKAGES I INSTALLED
    IN RETURN I CAN USE NIGHTLY PKGS & BLEEDING EDGE UPDATES
  */
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
    inputs.hyprland.overlays.default
    inputs.hyprlang.overlays.default
    inputs.hyprlock.overlays.default
    inputs.hypridle.overlays.default
    inputs.hyprpaper.overlays.default
    inputs.hyprcursor.overlays.default
    inputs.prismlauncher.overlays.default
  ];
}
