return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    vim.keymap.set("n", "<leader>o", ":ToggleTerm name=$fx <CR>", {})
    vim.keymap.set("n", "<leader>0", ":ToggleTerm direction=vertical name=$fx <CR>", {})
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
}
