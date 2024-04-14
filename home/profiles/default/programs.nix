{ pkgs, ...}:

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
#    obsidian

    # RUST OVERLAY
    rust-bin.stable.latest.default

    # HYPRLAND ECOSYSTEM | EXTRAPKGS
    hyprlang
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
    hyprland-protocols
    hyprpicker
    hyprshot
    fuzzel
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
