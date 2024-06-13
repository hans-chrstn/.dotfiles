local wezterm = require("wezterm")
local config = {
  color_scheme = "Catppuccin Mocha",
  font = wezterm.font("SF Mono", { weight = "Bold" }),
  font_size = 12,
  enable_tab_bar = false,
  window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
  },
}

return config

