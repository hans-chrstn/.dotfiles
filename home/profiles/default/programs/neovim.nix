{ config, pkgs, ... }:

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
    
    extraLuaConfig = ''
      ${builtins.readFile ../configs/neovim/options.lua}
    '';

    extraPackages = with pkgs; [
      shfmt
      lua-language-server
      rnix-lsp

      xclip
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [

      neodev-nvim
      telescope-fzf-native-nvim
      cmp_luasnip
      cmp-nvim-lsp
      luasnip
      friendly-snippets
      lualine-nvim
      nvim-web-devicons
      vim-nix
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ../configs/neovim/plugins/lsp.lua;
      } 

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      } 

      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      } 

      {
        plugin = nvim-cmp;
        config = toLuaFile ../configs/neovim/plugins/cmp.lua;
      } 

      {
        plugin = telescope-nvim;
        config = toLuaFile ../configs/neovim/plugins/telescope.lua;
      } 

      {
        plugin = (nvim-treesitter.withPlugins (p: [
	  p.tree-sitter-nix
	  p.tree-sitter-vim
	  p.tree-sitter-bash
	  p.tree-sitter-lua
	  p.tree-sitter-python
	  p.tree-sitter-json
	]));
	config = toLuaFile ../configs/neovim/plugins/treesitter.lua;
      }

    ];
  };
}
