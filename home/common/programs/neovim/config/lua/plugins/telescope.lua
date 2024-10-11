return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = "VeryLazy",  -- Use a more specific lazy loading event if possible
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",  -- Load on command
    config = require('config.telescope'),
  },
}

