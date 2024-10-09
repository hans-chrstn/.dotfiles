return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "BufWinEnter",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function ()
      require("bufferline").setup({})
    end
  }
}
