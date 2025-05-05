local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>d', function ()
  vim.diagnostic.open_float(nil, { focus = false })
end)

-- Map :w to the save_buffer function
local keys = {
}

for _, map in ipairs(keys) do
  keymap(map.mode, map.key, map.cmd, map.opts)
end
