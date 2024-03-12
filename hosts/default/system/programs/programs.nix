{ inputs, outputs, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [ 
    curl
    jq
    coreutils
    dmidecode
    ntfs3g
    iw
    libva-utils
    dbus
    parted
    wayland-protocols
    wayland-utils
    wlroots
    xwaylandvideobridge

    lutris

    floorp

    unzip
    p7zip
    wget

    wine
    winetricks

    discord
    
    #editor
    xclip
    wl-clipboard
    lunarvim

    #terminals
    kitty

    #filemanager
    ranger

    #portals
    xdg-desktop-portal-hyprland
    xdg-desktop-portal
    xdg-desktop-portal-gtk

    #hyprland stuff
    hyprland-protocols
    hyprpicker
    hyprlock
    hypridle
    hyprpaper
    libnotify
    grim
    slurp
    fuzzel
    neofetch
    brightnessctl
    playerctl
    wl-gammarelay-rs
    btop
    cava

    #ags
    upower
    libdbusmenu-gtk3
    networkmanager
    gobject-introspection
    gjs
    glib
    gtk-layer-shell
    gtk3
    gtk4
    gnome.gnome-bluetooth
    nodejs_21
    typescript
    meson
    #ags widget
    dart-sass
    morewaita-icon-theme
    sptlrx
    cascadia-code
    eza
    bat
    pipewire
    eww
      #pango
      #gdk-pixbuf
      #cairo
      #gcc
    gtk3.dev
    gtk-layer-shell.dev
    pango.dev
    gdk-pixbuf.dev
    cairo.dev
    glib.dev
    libgcc

    #downloader
    yt-dlp
    ffmpeg

  ];

  services.emacs = {
    enable = true;
    package = pkgs.emacs;

  };
  
  programs.steam.enable = true;

  programs.zsh.enable = true;
}
