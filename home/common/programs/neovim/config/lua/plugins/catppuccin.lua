return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  event = "BufWinEnter",
  priority = 1000,
  config = function()
    vim.cmd("colorscheme catppuccin-mocha")
    require("catppuccin").setup({
      --[[ term_colors = true,
      integrations = {
        treesitter = true,
        gitsigns = true,
        telescope = true,
        neotree = true,
        dashboard = true,
        bufferline = true,
      } ]]
    })
  end,
}
