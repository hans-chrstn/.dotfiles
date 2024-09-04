return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>e", "<cmd>Yazi<cr>", desc = "Open yazi at the current file",
    },
    {
      "<leader>cw", "<cmd>Yazi cwd<cr>", desc = "Open yazi at the current working directory",
    },
    {
      "<c-up>", "<cmd>Yazi toggle<cr>", desc = "Resume the last yazi session",
    },
  },
  config = function ()
    require("yazi").setup({


    })
  end,
}
