local wezterm = require('wezterm')
local config = {
  color_scheme = 'Catppuccin Mocha',
  font = wezterm.font('SF Mono', { weight = 'Medium' }),
  -- front_end = 'WebGpu',
  font_size = 12,
  enable_tab_bar = false,
  window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
  },

  launch_menu = {
    {
      label = 'Yazi',
      args = { 'yazi'},
    }
  },

  keys = {
    { key = 'r', mods = 'ALT', action = wezterm.action.ShowLauncher },
    { key = 'e', mods = 'ALT', action = wezterm.action.SpawnCommandInNewTab { args = { 'yazi' }, }, },
    { key = 't', mods = 'ALT', action = wezterm.action.SpawnTab 'DefaultDomain' },
    { key = 'w', mods = 'ALT', action = wezterm.action.CloseCurrentPane { confirm = true }, },
    { key = '[', mods = 'ALT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }, },
    { key = ']', mods = 'ALT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }, },
  },
}

if os.getenv("USER") == "toru" then
  config.enable_wayland = false
else
  config.enable_wayland = true
end

-- Moving to tabs using CTRL + 1-8 and F1-8
for i = 1, 8 do
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

