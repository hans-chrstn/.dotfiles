{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.mod.programs.zsh;
in {
  options.mod.programs.zsh = {
    enable = lib.mkEnableOption "Enable the zsh feature";
  };

  config = lib.mkIf cfg.enable {
    xdg.configFile."fsh" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/modules/home-manager/zsh/fsh/";
    };

    home.packages = with pkgs; [fzf];

    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      syntaxHighlighting.enable = false;
      shellAliases = {
      };

      initContent = ''
        source ~/.dotfiles/modules/home-manager/zsh/config/.p10k.zsh
        export EDITOR=nvim
        export VISUAL="$EDITOR"
        eval "$(direnv hook zsh)"
      '';

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "fast-syntax-highlighting";
          src = pkgs.zsh-fast-syntax-highlighting;
          file = "share/zsh/site-functions/fast-syntax-highlighting.plugin.zsh";
        }
        {
          name = "fzf-tab";
          src = pkgs.zsh-fzf-tab;
          file = "share/fzf-tab/fzf-tab.plugin.zsh";
        }
      ];
    };
  };
}
