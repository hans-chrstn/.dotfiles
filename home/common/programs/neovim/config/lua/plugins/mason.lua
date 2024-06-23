return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "pylint",
          "eslint_d",

          "stylua",
          "prettier",

          "lua-language-server",
          "rust-analyzer",
          "clangd",
          "css-lsp",
          "html-lsp",
          "typescript-language-server",
          "jdtls",
          "marksman",
          "pyright",
          "nil",
          "bash-language-server",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufRead", "BufNewFile" },
    config = function()
      require("lspconfig").lua_ls.setup({})
      require("lspconfig").rust_analyzer.setup({})
      require("lspconfig").clangd.setup({})
      require("lspconfig").cssls.setup({})
      require("lspconfig").html.setup({})
      require("lspconfig").tsserver.setup({})
      require("lspconfig").jdtls.setup({})
      require("lspconfig").marksman.setup({})
      require("lspconfig").pyright.setup({})
      require("lspconfig").nil_ls.setup({})
      require("lspconfig").bashls.setup({})

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
