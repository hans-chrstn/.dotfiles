{ pkgs, ... }:
{

  environment.variables = {
    VDPAU_DRIVER = "va_gl";
    POLKIT_AUTH_AGENT = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
    LIBVA_DRIVER_NAME = "iHD"; #"i965";
    #MESA_GL_VERSION_OVERRIDE = "4.5";
    GBM_BACKEND = "iHD";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    ANKI_WAYLAND = "1";
    #DISABLE_QT5_COMPAT = "0";
    DIRENV_LOG_FORMAT = "";
    #QT_QPA_PLATFORM = "wayland";
    #QT_WAYLAND_DISABLE_WINDOWDECORATION = "0";
    #QT_QPA_PLATFORMTHEME = "qt5ct";
    XDG_CURRENT_DESKTOP = "Hyprland";
#    XDG_SESSION_DESKTOP = "Hyprland";
#    WLR_BACKEND = "vulkan";
#    WLR_DRM_DEVICES = "/dev/dri/card0";
#    WLR_NO_HARDWARE_CURSORS = "1";
#    NIXOS_OZONE_WL = "1";
#    WLR_DRM_NO_ATOMIC = "1";
#    WLR_RENDERER = "vulkan";
#    __GL_GSYNC_ALLOWED = "0";
#    __GL_VRR_ALLOWED = "1";
#    __GLX_VENDOR_LIBRARY_NAME = "mesa";

    # REMOTE
    RUST_BACKTRACE="1";
    EDITOR = "lvim";
    VISUAL = "lvim";
  };
}
