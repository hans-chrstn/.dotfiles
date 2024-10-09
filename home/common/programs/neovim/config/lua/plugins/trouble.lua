return {
  "folke/trouble.nvim",
  cmd = "Trouble",  -- Load on :Trouble command
  keys = {          -- Load when any of these keys are pressed
    {
      "<leader>xx",
      "<cmd>Trouble<CR>",
      desc = "Toggle Trouble"
    },
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xl",
      "<cmd>Trouble loclist<CR>",
      desc = "Location List"
    },
    {
      "<leader>xq",
      "<cmd>Trouble qflist<CR>",
      desc = "Quickfix List"
    },
  },
  config = function()
    require("trouble").setup({
      -- Add any configuration settings here
      -- For example, you can customize icons, signs, and other options
      auto_open = false,  -- Automatically open Trouble when there are diagnostics
      auto_close = true,  -- Automatically close Trouble when no diagnostics are present
    })
  end,
}

