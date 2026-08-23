{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.dotfiles.desktop.hyprland;
in {
  options.dotfiles.desktop.hyprland = {
    enable = lib.mkEnableOption "Enable the hyprland feature";
    unstable = lib.mkEnableOption "Use the unstable flake input for Hyprland";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = lib.mkIf cfg.unstable inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = lib.mkIf cfg.unstable inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    home-manager.users.${config.dotfiles.primaryUser}.dotfiles.desktop.hyprland = {
      enable = true;
      unstable = cfg.unstable;
    };
  };
}
