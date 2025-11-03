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
    neofetch.enable = true;
    nix-index.enable = true;
    yazi.enable = true;
    zsh.enable = true;
  };

  fonts.fontconfig.enable = true;
  home = {
    packages = [
      inputs.dotnvf.packages."${pkgs.system}".default
    ];
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
