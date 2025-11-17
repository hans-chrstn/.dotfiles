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
    modules.neofetch
    modules.neovim
    modules.nix-index
    modules.yazi
    modules.shell
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
