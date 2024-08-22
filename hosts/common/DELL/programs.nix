{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    # FLAKED
    #inputs.nix-inspect.packages.${pkgs.system}.default

    # DEV ENV
    (python3.withPackages(ps: with ps; [
      pip
      tkinter
      debugpy
    ])) 
    (lua.withPackages(ls: with ls; [
      luarocks
    ]))
    luajit
    gnumake 
    nodejs
    nodePackages.sass
    eslint_d
    typescript
    bun
    sassc
    clang-tools
    clang
    gcc
    cl
    zig
    jansson
    cmake
    pkg-config

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
    cifs-utils

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
    unrar
    wget
    atool

    # EDITOR | EXTRAPKGS
    xclip
    wl-clipboard
    tree-sitter
    stylua
    neovim

    # TERMINALS
    kitty
    wezterm
    konsole

    # FILE MANAGER | EXTRAPKGS
    lf
    zathura 
    ctpv

    protonvpn-cli
  ];

}
