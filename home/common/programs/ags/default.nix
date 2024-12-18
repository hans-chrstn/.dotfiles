{ config, inputs, pkgs, ... }:

{
  imports = [ 
    inputs.ags.homeManagerModules.default
    #inputs.ags-v2.homeManagerModules.default
  ];

  programs.ags = {
    enable = true;
    #    configDir = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/ags/ags-v2";
    extraPackages = [
      pkgs.gtksourceview
      #webkitgtk
      pkgs.accountsservice
      inputs.astal.packages.${pkgs.system}.astal4

    ];
  };

  home.packages = with pkgs; [
      sassc
      bun
  ];
}
