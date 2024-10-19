{ inputs, pkgs, config, ... }:
{
  xdg.configFile = {
    "wezterm" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/wezterm/config/";
    };
    "wezterm/wezterm.lua" = {
      enable = false;
    };
  };

  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    #package = inputs.wezterm.packages.${pkgs.system}.default;
  };
}
