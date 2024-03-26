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
    intel-gpu-tools
    nix-prefetch-git
    fzf
    wirelesstools
    socat

    #mediaplayer
    vlc
    ffmpegthumbnailer

    #sr
    obs-studio

    lutris

    floorp

    unzip
    p7zip
    wget
    atool

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
    lf
    pistol
    zathura 
    less
    highlight

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
    file
    libglvnd
    libwebp
    mesa
    libdrm
    libxkbcommon

    #weather
    tenki

    #ags
    upower
    libdbusmenu-gtk3
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

    #eww
    eww
    mpd
    mpc-cli
    networkmanagerapplet
    dmenu
    gtk3.dev
    gtk-layer-shell.dev
    pango.dev
    gdk-pixbuf.dev
    cairo.dev
    glib.dev
    libgcc
    bluez
    code-minimap
    pamixer

    #downloader
    yt-dlp
    ffmpeg

    #cracked prismlauncher
    prismlauncher

  ];

  services.mpd.enable = true;
}
