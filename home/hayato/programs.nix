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
    protonvpn-gui

    glxinfo


    # DOWNLOADS PUBLIC GOOGLE DRIVE STUFF
    gdown

    # JAVA
    zulu

    #nur.repos.iagocq.ultimmc
    # GAMES
    inputs.prismlauncher.packages.${pkgs.system}.prismlauncher

    # RUST OVERLAY
    rust-bin.stable.latest.default

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
    lf

    # GAMING
    winetricks
    wineWowPackages.unstable
    lutris
    protontricks
    cartridges
    heroic
    gogdl

    # TIME
    tenki

    # BROWSER
    floorp
  ];
}
