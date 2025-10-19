return {
  "catppuccin/nvim",
  lazy = true,
  name = "catppuccin",
  event = { "ColorSchemePre", "UIEnter" },
  priority = 1000,
  config = require('config.catppuccin'),
}

