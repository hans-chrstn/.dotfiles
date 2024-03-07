{ config, lib, pkgs, ... }:

{
  imports = [
    ./location.nix
    ./power-button.nix
    ./tlp.nix
    ./gnome-services.nix
    ./greetd.nix


  ];

  #screensharing
  services.dbus = {
    enable = true;
    implementation = "broker";

  };

  services.gnome.gnome-keyring.enable = true;

  programs.thunar = {
    enable = true;


  };


  environment.sessionVariables = {
    POLKIT_AUTH_AGENT = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
    LIBVA_DRIVER_NAME = "i915";
    XDG_SESSION_TYPE = "wayland";
    #GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "mesa";
    #WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    WLR_RENDERER = "vulkan";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GTK_USE_PORTAL = "1";
    NIXOS_XDG_OPEN_USE_PORTAL = "1";
    EDITOR = "lvim";
    VISUAL = "lvim";
  }; 


}
