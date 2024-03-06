{ inputs, outputs, pkgs, ... }:

{
  
  environment.systemPackages = with pkgs; [ 
    curl
    jq
    coreutils
    dmidecode
    ntfs3g
    
    #editor
    xclip
    wl-clipboard

    lunarvim

    #terminals
    kitty

    #filemanager
    ranger

    #hyprland stuff
    xdg-desktop-portal-hyprland
    hyprpicker
    hyprlock
    hypridle
    hyprpaper
    libnotify
    #swww
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
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  
  programs.zsh.enable = true;
}
