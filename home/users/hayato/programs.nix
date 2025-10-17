{ inputs, pkgs, ...}:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = with pkgs; [
    libreoffice-qt
    telegram-desktop
    github-desktop
    webcord-vencord
    obsidian
    lightworks
    w3m

    glxinfo

    # DOWNLOADS PUBLIC GOOGLE DRIVE STUFF
    gdown

    # JAVA
    zulu



    # HYPRLAND ECOSYSTEM | EXTRAPKGS
    xdg-desktop-portal-hyprland
    hyprlang
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    hyprland-protocols
    libdrm
    pipewire
    sdbus-cpp
    wayland-protocols
    hyprpicker
    hyprshot
    neofetch

    #GAMING
    (lutris.override {
      extraPkgs = pkgs: [
        jansson
        winetricks
        (wineWowPackages.full.override {
          wineRelease = "staging";
          mingwSupport = true;
        })
      ];
    })
    protontricks
    cartridges
    heroic
    gogdl

    # TIME
    tenki
  ];
}
