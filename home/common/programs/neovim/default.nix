{ pkgs, inputs, config, ... }:
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
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-lsp-nvim
      nvim-treesitter.withAllGrammars
      bufferline-nvim
      catppuccin-nvim
      todo-comments-nvim
      comment-nvim
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      cmp_luasnip
      friendly-snippets
      cmp-buffer
      cmp-path
      dashboard-nvim
      gitsigns-nvim
      lsp-zero-nvim
      nvim-lspconfig
      lualine-nvim
      nvim-autopairs
      telescope-nvim
      nvim-web-devicons
      plenary-nvim
      toggleterm-nvim
      trouble-nvim
      nvim-ts-autotag
      yazi-nvim
      inputs.blink-cmp.packages.${pkgs.system}.default
    ];


    extraLuaConfig = ''
      local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
      if not (vim.uv or vim.loop).fs_stat(lazypath) then
        vim.fn.system({
          "git",
          "clone",
          "--filter=blob:none",
          "https://github.com/folke/lazy.nvim.git",
          "--branch=stable", -- latest stable release
          lazypath,
        })
      end
      vim.opt.rtp:prepend(lazypath)
      vim.api.nvim_set_option("clipboard", "unnamedplus")
      require("vim-options")
      require("lazy").setup("plugins")
    '';

  };

  xdg.configFile."nvim/lua" = {
    recursive = true;
    source = ./config/lua;
  };

  # xdg.configFile = {
  #   "nvim" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/home/common/programs/neovim/config/";
  #   };
  # };

}
