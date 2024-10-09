return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/trouble.nvim" }, -- Ensure trouble is loaded
  event = "VimEnter",
  config = function()
    local trouble = require("trouble")

    -- Check if trouble is available and set up lualine with trouble integration
    local symbols = {}
    if trouble then
      symbols = trouble.statusline({
        mode = "lsp_document_symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })
    end

    require("lualine").setup({
      options = {
        theme = "dracula",
      },
      sections = {
        lualine_c = {
          {
            symbols.get,
            cond = symbols.has,  -- Only show if symbols are available
          },
        },
      },
    })
  end,
}

