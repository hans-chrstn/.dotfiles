{ configs, pkgs, ... }:

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
    tmux
    lf

    #img
    ueberzug


    #hyprland stuff
    xdg-desktop-portal-hyprland
    hyprpicker
    hyprlock
    hypridle
    libnotify
    swww
    networkmanagerapplet
    grim
    slurp
    swaynotificationcenter
    fuzzel
    neofetch


    #test

    #(waybar.overrideAttrs (oldAttrs: {
    #    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    #  })
    #)

  ];
  
  xdg.portal.enable = true;
  
  programs.zsh.enable = true;
}
