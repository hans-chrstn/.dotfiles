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
    zulu8
    telegram-desktop
    github-desktop
    webcord-vencord
    #obsidian

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
    btop
    cava

    # SCREEN RECORD
    obs-studio

    # GAMING
    winetricks
    wineWowPackages.waylandFull
    lutris
    protontricks
    cartridges

    # TIME
    tenki

    # BROWSER
    floorp
  ];
}
