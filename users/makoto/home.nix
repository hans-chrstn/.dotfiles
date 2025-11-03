{
  inputs,
  modules,
  pkgs,
  ...
}: {
  imports = [
    modules.btop
    modules.dconf
    modules.direnv
    modules.git
    modules.lazygit
    modules.neofetch
    modules.neovim
    modules.nix-index
    modules.yazi
    modules.zsh
    inputs.dotstylix.homeModules.default
  ];
  theme = {
    enable = true;
    scheme = "desert-taupe-earth";
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
    zsh.enable = true;
  };

  fonts.fontconfig.enable = true;
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
