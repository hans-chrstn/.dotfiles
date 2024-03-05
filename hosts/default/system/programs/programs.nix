{ configs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    curl
    jq
    coreutils
    dmidecode
    
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

    #(waybar.overrideAttrs (oldAttrs: {
    #    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    #  })
    #)

  ];
  
  xdg.portal.enable = true;
  
  programs.zsh.enable = true;
}
