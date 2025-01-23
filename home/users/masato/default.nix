{
  ...
}: {
  imports = [
    ./overlays.nix
    ../../common/masato.nix
  ];



  home = {
    username = "masato";
    homeDirectory = "/home/masato";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.11";
}
