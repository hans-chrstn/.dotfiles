{config, pkgs, inputs, ...}:

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
    protontricks
    telegram-desktop
    github-desktop
    cartridges

  ];
}
