{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    # FLAKED
    #inputs.nix-inspect.packages.${pkgs.system}.default

    # DEV ENV
    python3Full
    nodejs
    nodePackages.sass
    typescript
    clang-tools
    clang
    gcc
    cl
    zig

    qt6.full

    # PKG UTILS
    fd
    shellcheck
    ripgrep
    openssl
    acpi
    pciutils
    glib-networking
    git
    curl
    jq
    coreutils
    usbutils
    dmidecode
    ntfs3g
    iw
    nil
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
    brightnessctl
    playerctl
    wl-gammarelay-rs
    file
    libglvnd
    libwebp
    libxkbcommon
    cmake
    upower
    libdbusmenu-gtk3
    gobject-introspection
    gjs
    glib
    gtk-layer-shell
    gtk3
    gtk4
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
    libnotify

    # DOWNLOADS YT MP4/MP3's
    yt-dlp

    # USB BOOT
    ventoy-full

    # DELL
    dell-command-configure

    # SECURE BOOT KEY MANAGER
    sbctl

    # MEDIAPLAYER
    vlc
    ffmpegthumbnailer
    ffmpeg

    # BROWSER
    #floorp

    # COMPRESS & ARCHIVE TOOLS
    unzip
    p7zip
    wget
    atool

    # EDITOR | EXTRAPKGS
    #lunarvim
    xclip
    wl-clipboard

    # TERMINALS
    kitty

    # FILE MANAGER | EXTRAPKGS
    lf
    zathura 
    ctpv

  ];

}
