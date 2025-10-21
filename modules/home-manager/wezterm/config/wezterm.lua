local wezterm = require('wezterm')

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.front_end = wezterm.frontends.webgpu()

config.window_decorations = "RESIZE"

config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

config.launch_menu = {
  {
    label = 'Yazi',
    args = { 'yazi' },
  }
}

config.keys = {
  { key = 'r', mods = 'ALT', action = wezterm.action.ShowLauncher },

  { key = 'e', mods = 'ALT', action = wezterm.action.SpawnCommandInNewTab { args = { 'yazi' } } },

  { key = 't', mods = 'ALT', action = wezterm.action.SpawnTab {} },

  { key = 'w', mods = 'ALT', action = wezterm.action.CloseCurrentPane { confirm = true } },

  { key = '[', mods = 'ALT', action = wezterm.action.SplitHorizontal {} },
  { key = ']', mods = 'ALT', action = wezterm.action.SplitVertical {} },
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = wezterm.action.ActivateTab(i - 1),
  })

  table.insert(config.keys, {
    key = 'F' .. tostring(i),
    action = wezterm.action.ActivateTab(i - 1),
  })
end

return config
