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
    webcord-vencord
    obsidian
    w3m

    # JAVA
    zulu
    nodejs

    # RUST OVERLAY
    rust-bin.stable.latest.default

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

    # EDITING
    #davinci-resolve
    lmms
    audacity
    bitwarden-cli

    # TIME
    tenki

    brave
  ];
}
