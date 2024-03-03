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
    wget
    floorp
    p7zip
    wine
    winetricks
    libreoffice-qt
    zulu8
    protontricks
    rustc
    cargo
    protonvpn-gui
    gnome.gnome-software 
    gnome.gnome-tweaks
    telegram-desktop
    unzip
    steam
    discord
    github-desktop

    #test

  ];
}
