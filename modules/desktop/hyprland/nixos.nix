{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.mod.wm.hyprland;
in {
  options.mod.wm.hyprland = {
    enable = lib.mkEnableOption "Enable the hyprland feature";
    unstable = lib.mkEnableOption "Use the unstable flake input for Hyprland";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = lib.mkIf cfg.unstable inputs.hyprland.packages.${pkgs.system}.hyprland;
      portalPackage = lib.mkIf cfg.unstable inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
    };

    home-manager.users.${config.mainUser}.mod.wm.hyprland = {
      enable = true;
      unstable = cfg.unstable;
    };
  };
}
