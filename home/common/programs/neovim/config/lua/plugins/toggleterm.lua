return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = "ToggleTerm",  -- Load on :ToggleTerm command
  keys = {             -- Lazy load on these keybindings
    { "<leader>oo", ":ToggleTerm direction=horizontal<CR>", desc = "Open horizontal terminal" },
    { "<leader>o0", ":ToggleTerm direction=vertical<CR>", desc = "Open vertical terminal" },
    { "<leader>gg", function() Lazygit_toggle() end, desc = "Open Lazygit" },
  },
  config = require('config.toggleterm'),
}

