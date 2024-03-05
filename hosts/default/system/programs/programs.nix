{ configs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    curl
    jq
    coreutils
    dmidecode
    
    #editor
    neovim
    xclip
    wl-clipboard

    #hyprland stuff
    xdg-desktop-portal-hyprland
    hyprpicker
    hyprlock
    hypridle
    #eww
    libnotify
    swww
    kitty
    networkmanagerapplet
    grim
    slurp
    swaynotificationcenter
    fuzzel

    #(waybar.overrideAttrs (oldAttrs: {
    #    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    #  })
    #)

  ];
  
  xdg.portal.enable = true;
  
  programs.zsh.enable = true;
}
