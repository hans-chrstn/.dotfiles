return {
  "dundalek/lazy-lsp.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "VonHeikemen/lsp-zero.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
  },
  event = "BufReadPre",
  config = function()
    local lsp_zero = require("lsp-zero")

    lsp_zero.on_attach(function(client, bufnr)
      -- see :help lsp-zero-keybindings to learn the available actions
      lsp_zero.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false
      })
    end)

    require("lazy-lsp").setup {}
  end,
}
