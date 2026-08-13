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
    lazygit.enable = true;
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

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    yt-dlp
    inputs.attic.packages.${pkgs.system}.default
  ];
  home = {
    username = "makoto";
    homeDirectory = "/home/makoto";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}
