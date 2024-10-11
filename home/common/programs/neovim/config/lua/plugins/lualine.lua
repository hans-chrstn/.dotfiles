return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/trouble.nvim" }, -- Ensure trouble is loaded
  event = { "VimEnter", "VeryLazy" },
  config = require('config.lualine'),
}

