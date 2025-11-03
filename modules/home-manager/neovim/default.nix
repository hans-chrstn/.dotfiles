{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.mod.programs.neovim;
in {
  options.mod.programs.neovim = {
    enable = lib.mkEnableOption "Enable the neovim feature";
  };

  config = lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = true;
      extraPackages = with pkgs; [
        xclip
        xsel
        wl-clipboard
        ripgrep
        fd
        trash-cli
        imagemagick
        ghostscript
        mermaid-cli
      ];
    };

    xdg.configFile."nvim" = {
      recursive = true;
      source = ./config;
    };
  };
}
