return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = "ToggleTerm",  -- Load on :ToggleTerm command
  keys = {             -- Lazy load on these keybindings
    { "<leader>oo", ":ToggleTerm direction=horizontal<CR>", desc = "Open horizontal terminal" },
    { "<leader>o0", ":ToggleTerm direction=vertical<CR>", desc = "Open vertical terminal" },
    { "<leader>gg", function() Lazygit_toggle() end, desc = "Open Lazygit" },
  },
  config = function()
    -- Define the Lazygit toggle function
    local lazygit = require("toggleterm.terminal").Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.keymap.set("n", "q", "<cmd>close<CR>", { noremap = true, silent = true, buffer = term.bufnr })
      end,
      on_close = function()
        vim.cmd("startinsert!")
      end,
    })

    -- Global function for toggling Lazygit
    function _G.Lazygit_toggle()
      lazygit:toggle()
    end

    -- Set up the keybindings for toggleterm
    vim.keymap.set("n", "<leader>oo", ":ToggleTerm direction=horizontal<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>o0", ":ToggleTerm direction=vertical<CR>", { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>gg", "<cmd>lua Lazygit_toggle()<CR>", { noremap = true, silent = true })

    -- Configuration for toggleterm.nvim
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 12
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      autochdir = false,
      autoscroll = true,
    })
  end,
}

