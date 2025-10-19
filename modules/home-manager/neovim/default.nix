{
  lib,
  pkgs,
  config,
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

      plugins = with pkgs.vimPlugins;
        [
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
          lazy-nvim
          copilot-lua
        ]
        ++ [pkgs.drop];
      extraLuaConfig = ''
      '';
    };

    xdg.configFile."nvim" = {
      recursive = true;
      source = ./config;
    };
  };
}
