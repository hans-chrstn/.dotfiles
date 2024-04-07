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
    protontricks
    telegram-desktop
    github-desktop
    cartridges
    webcord-vencord
    obsidian
  ];
}
