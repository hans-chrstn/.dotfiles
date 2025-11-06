{
  modules,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    modules.btop
    modules.dconf
    modules.direnv
    modules.discord
    modules.git
    modules.lazygit
    modules.monitors
    modules.neofetch
    modules.neovim
    modules.vscode
    modules.yazi
    modules.zen
    modules.zsh
    inputs.dotstylix.homeModules.default
  ];

  theme = {
    enable = true;
    scheme = "nord";
  };

  monitors = {
    main = {
      name = "eDP-1";
      width = 1366;
      height = 768;
      refreshRate = 59.999;
    };
  };

  home = {
    username = "yu";
    homeDirectory = "/home/yu";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  mod.programs = {
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
    lazygit.enable = true;
    neovim.enable = true;
    neofetch.enable = true;
    vscode.enable = true;
    yazi.enable = true;
    zen.enable = true;
    zsh.enable = true;
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    moonlight-qt
  ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}
