{ config, inputs, pkgs, ... }:

{
  imports = [ 
    inputs.ags.homeManagerModules.default
  ];

  programs.ags = {
    enable = true;
    configDir = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/ags/ags-new";
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
}
