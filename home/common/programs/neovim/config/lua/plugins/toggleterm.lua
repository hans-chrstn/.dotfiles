return {
  "akinsho/toggleterm.nvim",
  version = "*",
  cmd = "ToggleTerm",
  event = "BufReadPost",
  config = function()
    local lazygit = require("toggleterm.terminal").Terminal:new({
      cmd = "lazygit",
      hidden = true,
      direction = "float",
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.keymap.set("n", "q", "<cmd>close<CR>", {
          noremap = true,
          silent = true,
        })
      end,
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })

    function Lazygit_toggle()
      lazygit:toggle()
    end

    vim.keymap.set("n", "<leader>oo", ":ToggleTerm direction=horizontal <CR>", {
      noremap = true,
      silent = true,
    })
    vim.keymap.set("n", "<leader>o0", ":ToggleTerm direction=vertical <CR>", {
      noremap = true,
      silent = true,
    })
    vim.keymap.set("n", "<leader>gg", "<cmd>lua Lazygit_toggle()<CR>", {
      noremap = true,
      silent = true,
    })
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
