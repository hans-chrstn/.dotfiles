{ inputs, pkgs, ...}:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = with pkgs; [
    #libreoffice-qt
    #telegram-desktop
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



    # RUST OVERLAY
    rust-bin.stable.latest.default

    # HYPRLAND ECOSYSTEM | EXTRAPKGS
    hyprlock
    hypridle
    hyprpaper
    hyprpicker
    hyprshot
    neofetch

    # GAMING
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
    bottles
    protonup-qt
    protontricks
    cartridges
    heroic
    gogdl
    sunshine

    # GAMES
    inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
    #nur.repos.iagocq.ultimmc

    # TIME
    tenki
  ];
}
