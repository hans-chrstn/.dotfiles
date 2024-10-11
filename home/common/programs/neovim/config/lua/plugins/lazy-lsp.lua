return {
  "dundalek/lazy-lsp.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "VonHeikemen/lsp-zero.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "iguanacucumber/magazine.nvim",
  },
  event = "BufReadPre",
  config = require('config.lazy-lsp'),
}
