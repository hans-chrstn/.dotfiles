{ inputs, pkgs, ...}:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = with pkgs; [
    # libreoffice-qt
    # webcord-vencord
    # obsidian
    w3m

    hyprshot

    # EDITING
    #davinci-resolve
    lmms

    # TIME
    tenki

    brave
  ];
}
