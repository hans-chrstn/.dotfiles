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
    (discord.override {
      # withOpenASAR = true;
      withVencord = true;
    })
    discord-rpc
    # obsidian
    moonlight-qt

    hyprshot

    # EDITING
    #davinci-resolve
    # lmms

    # TIME
    tenki

    brave
    libva-utils
  ];
}
