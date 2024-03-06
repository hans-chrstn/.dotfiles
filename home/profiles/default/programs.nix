{config, pkgs, inputs, ...}:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = with pkgs; [
    wget
    floorp
    p7zip
    wine
    winetricks
    libreoffice-qt
    zulu8
    protontricks
    protonvpn-gui
    telegram-desktop
    unzip
    steam
    discord
    github-desktop
    cartridges

  ];
}
