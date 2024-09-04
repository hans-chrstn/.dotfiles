{ config, pkgs, ... }:

{

  xdg.configFile."fsh" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/zsh/fsh/";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    syntaxHighlighting.enable = false;
    shellAliases = {

    };


    initExtra = ''
      source ~/.dotfiles/home/common/programs/zsh/config/.p10k.zsh
      export EDITOR=nvim
      export VISUAL="$EDITOR"
      export FZF_DEFAULT_OPTS=" \
      --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
      --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
      --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
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

  # programs.starship = {
  #   enable = true;
  # };
}
