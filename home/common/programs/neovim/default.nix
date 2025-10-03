{ pkgs, inputs, ... }:
{
  programs.neovim = {
    enable = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraPackages = with pkgs; [
      xclip
      wl-clipboard
      curl
      gcc
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-lsp-nvim
      #nvim-treesitter.withAllGrammars
      barbar-nvim
      catppuccin-nvim
      todo-comments-nvim
      comment-nvim
      cmp-nvim-lsp
      luasnip
      cmp_luasnip
      friendly-snippets
      cmp-buffer
      cmp-async-path
      cmp-latex-symbols
      dashboard-nvim
      # gitsigns-nvim
      lsp-zero-nvim
      nvim-lspconfig
      lualine-nvim
      nvim-autopairs
      telescope-nvim
      telescope-ui-select-nvim
      telescope-fzf-native-nvim
      nvim-web-devicons
      plenary-nvim
      toggleterm-nvim
      trouble-nvim
      nvim-ts-autotag
      yazi-nvim
      cord-nvim
      which-key-nvim
      render-markdown-nvim
      nvim-cmp
      drop
      lazy-nvim
      copilot-lua
    ];
    extraLuaConfig = ''
    '';

  };

  xdg.configFile."nvim" = {
    recursive = true;
    source = ./config;
  };
}
