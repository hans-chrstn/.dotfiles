return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = {
    {
      "nvim-tree/nvim-web-devicons",
    },
  },
  config = require("config.dashboard")
}
