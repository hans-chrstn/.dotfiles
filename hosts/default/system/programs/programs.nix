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

    #hyprland stuff
    xdg-desktop-portal-hyprland
    hyprpicker
    hyprlock
    hypridle
    libnotify
    swww
    kitty
    networkmanagerapplet
    grim
    slurp
    swaynotificationcenter
    fuzzel
    neofetch
    lunarvim

    #test

    #(waybar.overrideAttrs (oldAttrs: {
    #    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    #  })
    #)

  ];
  
  xdg.portal.enable = true;
  
  programs.zsh.enable = true;
}
