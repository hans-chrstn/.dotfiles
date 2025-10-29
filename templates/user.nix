{...}: {
  imports = [
  ];

  home = {
    username = "NEW_MACHINE_NAME";
    homeDirectory = "/home/NEW_MACHINE_NAME";
    sessionVariables = {
      # EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}
