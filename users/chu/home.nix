{...}: {
  imports = [
  ];

  home = {
    username = "chu";
    homeDirectory = "/home/chu";
    sessionVariables = {
      # EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}
