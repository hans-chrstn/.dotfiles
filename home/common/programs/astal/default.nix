{ inputs, config, pkgs, ... }:
{
   imports = [ 
    inputs.astal.homeManagerModules.default
  ];

  programs.astal = {
    enable = true;
    configDir = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/astal/astal";
    extraPackages = with pkgs; [
      libadwaita
    ];
  }; 

}
