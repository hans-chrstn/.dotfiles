{ pkgs, inputs, ... }:

{
  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    defaultEditor = true;
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    
    extraPackages = with pkgs; [
      xclip
      wl-clipboard
      lua-language-server
      stylua
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }
      {
        plugin = lazy-nvim;
        config = toLua "require(\"lazy\").setup()";
      }
      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }
    ];
  };
}
