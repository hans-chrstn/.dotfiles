{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.mod.desktop.wayland;
in {
  options.mod.desktop.wayland = {
    enable = lib.mkEnableOption "Enable generic Wayland environment (portals, vars)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      grim
      satty
      jq
    ];
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
      ];
      config = {
        common = {
          default = ["gtk"];
          "org.freedesktop.impl.portal.FileChooser.OpenFile" = "gtk";
          "org.freedesktop.impl.portal.FileChooser.SaveFile" = "gtk";
          "org.freedesktop.impl.portal.FileChooser.SaveFiles" = "gtk";
          "org.freedesktop.impl.portal.ScreenCast" = "gnome";
          "org.freedesktop.impl.portal.Screenshot" = "gnome";
          "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
        };
        hyprland = {
          default = ["hyprland" "gtk"];
          "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
          "org.freedesktop.impl.portal.Screenshot" = "hyprland";
          "org.freedesktop.impl.portal.RemoteDesktop" = "hyprland";
        };
      };
    };

    home.sessionVariables = {
      QT_QPA_PLATFORM = "wayland;xcb";
      XDG_SESSION_TYPE = "wayland";
      GDK_BACKEND = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      GTK_USE_PORTAL = "1";
      NIXOS_XDG_OPEN_USE_PORTAL = "1";
      ANKI_WAYLAND = "1";
      DIRENV_LOG_FORMAT = "";
      NIXOS_OZONE_WL = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      GDK_SCALE = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      XDG_BACKEND = "wayland";
    };
  };
}
