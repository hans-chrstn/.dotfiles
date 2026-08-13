{
  inputs,
  modules,
  pkgs,
  ...
}: {
  theme = {
    enable = true;
    scheme = "tokyo-night";
  };

  mod.programs = {
    btop = {
      enable = true;
      enableCustomSettings = true;
    };
    dconf.enable = true;
    direnv.enable = true;
    git = {
      enable = true;
      userName = "hayato-oo";
      userEmail = "xuhiko13@gmail.com";
    };
    neovim.enable = true;
    neofetch.enable = true;
    nix-index.enable = true;
    yazi.enable = true;
    shell = {
      enableZsh = false;
      enableFish = true;
      enableStarship = true;
    };
  };

  home.packages = with pkgs; [
    inputs.attic.packages.${pkgs.system}.default
  ];

  fonts.fontconfig.enable = true;
  home = {
    username = "rei";
    homeDirectory = "/home/rei";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}
