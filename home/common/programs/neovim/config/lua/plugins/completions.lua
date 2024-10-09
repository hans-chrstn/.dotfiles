return {
  'saghen/blink.cmp',
  lazy = false, -- lazy loading handled internally
  dependencies = 'rafamadriz/friendly-snippets',
  event = { 'InsertEnter' },
  version = 'v0.*',
  config = function ()
    local blink = require('blink.cmp').setup({
      highlight = {
        use_nvim_cmp_as_default = true,
      },
      nerd_font_variant = 'normal',
      accept = { auto_brackets = { enabled = true } }
    })
  end
}
