{ inputs, pkgs, ...}:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    libreoffice-qt
    github-desktop
    webcord-vencord
    obsidian
    w3m

    # JAVA
    zulu

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

    # GAMES
    inputs.prismlauncher.packages.${pkgs.system}.prismlauncher
    #nur.repos.iagocq.ultimmc

    # TIME
    tenki
  ];
}
