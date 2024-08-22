return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    local symbols = require("trouble").statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      hl_group = "lualine_c_normal",
    })
    require("lualine").setup({
      options = {
        theme = "dracula",
      },
      sections = {
        lualine_c = {
          {
            symbols.get,
            cond = symbols.has,
          },
        },
      },
    })
  end,
}
