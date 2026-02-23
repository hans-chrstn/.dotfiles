{
  modules,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    modules.ai
    modules.btop
    modules.dconf
    modules.direnv
    modules.discord
    modules.git
    modules.lazygit
    modules.monitors
    modules.neofetch
    modules.neovim
    modules.niri
    modules.nyxt
    modules.shell
    modules.vpn
    modules.vscode
    modules.widgets
    modules.yazi
    modules.zen
    inputs.dotstylix.homeModules.default
  ];

  theme = {
    enable = true;
    scheme = "desert-taupe-earth";
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
    ai = {
      enableGemini = true;
    };
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
    niri.enable = true;
    nyxt.enable = true;
    vpn = {
      enableWireguard = true;
    };
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

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    feishin
    moonlight-qt
    tradingview
  ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}
