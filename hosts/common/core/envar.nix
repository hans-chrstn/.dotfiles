{ pkgs, ... }:
{

  environment = {
    localBinInPath = true;
    sessionVariables = {
      LIBVIRTD_ARGS="";
      NIXOS_CONFIG_DIR = "\${HOME}/.dotfiles/";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_DATA_HOME = "\${HOME}/.local/share";
      NIXPKGS_ALLOW_INSECURE = "1";
      NIXPKGS_ALLOW_UNFREE = "1";
      POLKIT_AUTH_AGENT = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      GDK_BACKEND = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      GTK_USE_PORTAL = "1";
      NIXOS_XDG_OPEN_USE_PORTAL = "1";
      ANKI_WAYLAND = "1";
      DISABLE_QT5_COMPAT = "0";
      DIRENV_LOG_FORMAT = "";
      #LIBSEAT_BACKEND = "logind";
      NIXOS_OZONE_WL = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "0";
      GDK_SCALE = "2";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      NVD_BACKEND = "direct";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      #WLR_DRM_DEVICES = "/dev/dri/card1";
      #WLR_RENDERER = "vulkan";
      WLR_NO_HARDWARE_CURSORS = "1";
      WLR_DRM_NO_ATOMIC = "1";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";

      # REMOTE
      RUST_BACKTRACE="1";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
