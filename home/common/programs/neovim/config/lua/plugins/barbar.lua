return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function () vim.g.barbar_auto_setup = false end,
  config = function ()
    local barbar = require('barbar')
    barbar.setup({
      insert_at_end = true,
    })
  end
}
