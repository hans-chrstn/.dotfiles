{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
    inputs.hyprland.overlays.default
    inputs.hyprlang.overlays.default
    inputs.hyprlock.overlays.default
    inputs.hypridle.overlays.default
    inputs.hyprpaper.overlays.default
    inputs.hyprcursor.overlays.default
  ];
}
