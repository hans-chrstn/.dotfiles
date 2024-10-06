local ensure_installed = {}

local function check(list)
  for tool, exec in pairs(list) do  -- Change to pairs for key-value pairs
    if vim.fn.executable(exec) == 1 then
      table.insert(ensure_installed, tool)  -- Add the tool's name for installation
    end
  end
end

local list_to_check = {
  black = "python",
  isort = "python",
  -- lua_language_server = "lua-language-server",
  -- rust_analyzer = "rust-analyzer",
  stylua = "stylua",
  clangd = "clangd",
  --
  -- "typescript-language-server",
  jdtls = "java",
  -- "marksman",
  -- nil = "nil",
  -- "bash-language-server",
  -- "kotlin-language-server" = "java",
  -- "glsl_analyzer",
};


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
        ensure_installed = vim.list_extend(ensure_installed, {
          "eslint_d",

          "prettier",
          "css-lsp",
          "html-lsp",
          "nil",
        }),
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities
      })
      lspconfig.clangd.setup({
        capabilities = capabilities,
        cmd = {
          "clangd",
          "--background-index",
          "--header-insertion=never",
          "--log=verbose"
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = lspconfig.util.root_pattern(
          'meson.build', 'CMakeLists.txt', '.git'
        ),
        settings = {
          cpp = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'openFilesOnly',
            },
          }
        },
        on_attach = function (client, bufnr)
          local opts = { noremap=true, silent=true }
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
          vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
        end
      })
      lspconfig.cssls.setup({
        capabilities = capabilities
      })
      lspconfig.html.setup({
        capabilities = capabilities
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities
      })
      lspconfig.jdtls.setup({
        capabilities = capabilities
      })
      lspconfig.marksman.setup({
        capabilities = capabilities
      })
      lspconfig.nil_ls.setup({
        capabilities = capabilities
      })
      lspconfig.bashls.setup({
        capabilities = capabilities
      })

      lspconfig.kotlin_language_server.setup({
        capabilities = capabilities
      })

      lspconfig.glsl_analyzer.setup({
        capabilities = capabilities
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gD", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
  check(list_to_check)

}
