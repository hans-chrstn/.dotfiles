{ config, inputs, pkgs, ... }:

{
  imports = [ 
    inputs.ags.homeManagerModules.default
    #inputs.ags-v2.homeManagerModules.default
  ];

  programs.ags = {
    enable = true;
    configDir = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/ags/ags-new-ts";
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
}
