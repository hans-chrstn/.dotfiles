{ configs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    curl
    jq
    coreutils
    dmidecode
    
    #hyprland stuff
    eww
    mako
    libnotify
    swww
    kitty
    networkmanagerapplet
    rofi-wayland
    #wofi
    (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )

  ];
  
  xdg.portal.enable = true;
  
  programs.zsh.enable = true;
}
