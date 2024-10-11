return {
  {
    'iguanacucumber/magazine.nvim',
    name = "nvim-cmp",
    version = false,
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
      'hrsh7th/cmp-buffer',
      'FelipeLema/cmp-async-path',
      'kdheepak/cmp-latex-symbols',
    },
    config = require('config.magazine'),
  },
}
