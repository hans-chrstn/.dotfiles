return function()
  local lsp_zero = require("lsp-zero")

  lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings to learn the available actions
    lsp_zero.default_keymaps({
      buffer = bufnr,
      preserve_mappings = false
    })
  end)

  require("lazy-lsp").setup ({
    excluded_servers = {
      "ccls",                            -- prefer clangd
      "denols",                          -- prefer eslint and ts_ls
      "docker_compose_language_service", -- yamlls should be enough?
      "flow",                            -- prefer eslint and ts_ls
      "ltex",                            -- grammar tool using too much CPU
      "quick_lint_js",                   -- prefer eslint and ts_ls
      "scry",                            -- archived on Jun 1, 2023
      "tailwindcss",                     -- associates with too many filetypes
      "biome",                           -- not mature enough to be default
      "oxlint",                          -- prefer eslint
    },
    preferred_servers = {
      markdown = {},
      python = { "basedpyright", "ruff" },
    },
  })
end
