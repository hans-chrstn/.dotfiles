return function()
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
end
