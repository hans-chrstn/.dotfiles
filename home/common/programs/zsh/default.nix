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
      export EDITOR=lvim
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
       src = pkgs.fetchFromGitHub {
         owner = "zdharma-continuum";
         repo = "fast-syntax-highlighting";
         rev = "cf318e06a9b7c9f2219d78f41b46fa6e06011fd9";
         sha256 = "1bmrb724vphw7y2gwn63rfssz3i8lp75ndjvlk5ns1g35ijzsma5";
       };
      }
      {
       name = "fzf-tab";
       src = pkgs.fetchFromGitHub {
         owner = "Aloxaf";
         repo = "fzf-tab";
         rev = "c7fb028ec0bbc1056c51508602dbd61b0f475ac3";
         sha256 = "061jjpgghn8d5q2m2cd2qdjwbz38qrcarldj16xvxbid4c137zs2";
       };
      }
    ];

  };
  programs.starship = {
    enable = true;
  };
}
