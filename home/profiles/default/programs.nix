{config, pkgs, inputs, ...}:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = with pkgs; [
    spotify
    spicetify-cli
    discord
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
    steam
    gnome.gnome-software 
    gnome.gnome-tweaks
    telegram-desktop
    hyprland
  ];
}
