{ pkgs, ... }:

{
  home.packages = with pkgs; [
    
  ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = false;
    enableVteIntegration = true;
    syntaxHighlighting.enable = false;
    shellAliases = {

    };


    initExtra = ''
      source ~/.dotfiles/home/profiles/default/programs/zsh/config/.p10k.zsh
      export EDITOR=lvim
      export VISUAL="$EDITOR"
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
         rev = "bf3ef5588af6d3bf7cc60f2ad2c1c95bca216241";
         sha256 = "0hv21mp6429ny60y7fyn4xbznk31ab4nkkdjf6kjbnf6bwphxxnk";
       };
      }
    ];

  };
  programs.starship = {
    enable = true;
  };
}
