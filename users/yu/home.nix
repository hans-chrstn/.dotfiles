{pkgs, ...}: {
  theme = {
    enable = true;
    scheme = "tokyo-night";
  };

  monitors = {
    main = {
      name = "eDP-1";
      width = 1366;
      height = 768;
      refreshRate = 59.999;
    };
  };

  programs.codex.enable = true;

  home = {
    username = "yu";
    homeDirectory = "/home/yu";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  dotfiles = {
    programs = {
      btop = {
        enable = true;
        enableCustomSettings = true;
      };
      dconf.enable = true;
      direnv.enable = true;
      discord.enable = true;
      git = {
        enable = true;
        userName = "hayato-oo";
        userEmail = "xuhiko13@gmail.com";
      };
      kitty.enable = true;
      lazygit.enable = true;
      neovim.enable = true;
      neofetch.enable = true;
      nyxt.enable = true;
      vscode.enable = true;
      yazi.enable = true;
      zen.enable = true;
      shell = {
        enableZsh = false;
        enableNushell = true;
        enableFish = true;
        enableStarship = true;
      };
    };
    desktop.widgets.quickshell.enable = true;
    networking.vpn.enableWireguard = true;
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    feishin
    moonlight-qt
    tradingview
    antigravity-cli
    libreoffice
  ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}
