{ inputs, outputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    # PKG UTILS
    curl
    jq
    coreutils
    usbutils
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
    vdpauinfo
    nix-prefetch-git
    fzf
    wirelesstools
    socat
    rust-bin.stable.latest.default
    cage

    # HYPRLAND ECOSYSTEM | EXTRAPKGS
    hyprlang
    hyprcursor
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
    cmake

    # AGS WIDGET | EXTRAPKGS | REQs
    upower
    libdbusmenu-gtk3
    gobject-introspection
    gjs
    glib
    gtk-layer-shell
    gtk3
    gtk4
    nodejs_21
    typescript
    meson
    dart-sass
    eza
    bat
    pipewire
    mpd
    mpv
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

    # DOWNLOADS YT MP4/MP3's
    yt-dlp

    # USB BOOT
    ventoy

    # DELL
    dell-command-configure

    # SECURE BOOT KEY MANAGER
    sbctl

    # MEDIAPLAYER
    vlc
    ffmpegthumbnailer
    ffmpeg

    # SCREEN RECORD
    obs-studio


    # BROWSER
    floorp

    # COMPRESS & ARCHIVE TOOLS
    unzip
    p7zip
    wget
    atool

    # RUN WIN EXE's
    winetricks
    wineWowPackages.waylandFull
    lutris

    # EDITOR | EXTRAPKGS
    lunarvim
    xclip
    wl-clipboard

    # TERMINALS
    kitty

    # FILE MANAGER | EXTRAPKGS
    lf
    zathura 
    ctpv
    
    # TIME
    tenki

  ];

}
