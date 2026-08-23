{...}: {
  imports = [
  ];

  home = {
    username = "NEW_USERNAME";
    homeDirectory = "/home/NEW_USERNAME";
    sessionVariables = {
      # EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}
