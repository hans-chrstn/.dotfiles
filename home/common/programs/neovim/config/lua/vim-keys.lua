local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ' '

-- Map :w to the save_buffer function
local keys = {
}

for _, map in ipairs(keys) do
  keymap(map.mode, map.key, map.cmd, map.opts)
end
