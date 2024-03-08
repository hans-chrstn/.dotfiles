{ inputs, outputs, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [ 
    curl
    jq
    coreutils
    dmidecode
    ntfs3g
    iw
    polkit_gnome

    steam
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

    #hyprland stuff
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

    #downloader
    yt-dlp
    ffmpeg

  ];
  
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ 
    pkgs.xdg-desktop-portal-gtk 
    pkgs.xdg-desktop-portal
  ];

  
  programs.zsh.enable = true;
}
