{ inputs, outputs, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [ 
    curl
    jq
    coreutils
    dmidecode
    ntfs3g

    steam

    protonvpn-gui

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
    swaynotificationcenter
    fuzzel
    neofetch
    brightnessctl
    playerctl


    #test

    #(waybar.overrideAttrs (oldAttrs: {
    #    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    #  })
    #)

  ];
  
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ 
    pkgs.xdg-desktop-portal-gtk 
    pkgs.xdg-desktop-portal
  ];

  
  programs.zsh.enable = true;
}
