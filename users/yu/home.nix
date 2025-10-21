{
  modules,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    modules.home-manager.btop
    modules.home-manager.dconf
    modules.home-manager.direnv
    modules.home-manager.discord
    modules.home-manager.git
    modules.home-manager.lazygit
    modules.home-manager.neofetch
    modules.home-manager.niri
    modules.home-manager.vscode
    modules.home-manager.yazi
    modules.home-manager.wezterm
    modules.home-manager.zen
    modules.home-manager.zsh
    inputs.dotstylix.homeModules.default
  ];

  theme = {
    enable = true;
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
    neofetch.enable = true;
    niri.enable = true;
    vscode.enable = true;
    wezterm.enable = true;
    yazi.enable = true;
    zen.enable = true;
    zsh.enable = true;
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    inputs.dotnixvim.packages."${pkgs.system}".default
  ];

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}
