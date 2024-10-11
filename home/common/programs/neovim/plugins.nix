{ pkgs, ... }:
{
  render-markdown = pkgs.vimUtils.buildVimPlugin {
    name = "render-markdown";
    src = pkgs.fetchFromGitHub {
      owner = "MeanderingProgrammer";
      repo = "render-markdown.nvim";
      rev = "main";
      hash = "sha256-dotx3oYjI4Z/xia0ycPaxYjpRoslU1ft7F7a+9U56IY=";
    };
  }; 

  magazine = pkgs.vimUtils.buildVimPlugin {
    name = "magazine";
    src = pkgs.fetchFromGitHub {
      owner = "iguanacucumber";
      repo = "magazine.nvim";
      rev = "main";
      hash = "sha256-qobf9Oyt9Voa2YUeZT8Db7O8ztbGddQyPh5wIMpK/w8=";
    };
  };

  drop = pkgs.vimUtils.buildVimPlugin {
    name = "drop";
    src = pkgs.fetchFromGitHub {
      owner = "folke";
      repo = "drop.nvim";
      rev = "main";
      hash = "sha256-UZ7060Fw9oTib1xJuMreBmpl5V9zEw0tYynwsasvLXw=";
    };
  };
}
