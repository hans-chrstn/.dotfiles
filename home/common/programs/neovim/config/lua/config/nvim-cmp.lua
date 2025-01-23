return function()
  local cmp = require('cmp')
  require('luasnip.loaders.from_vscode').lazy_load()

  cmp.setup({
    auto_brackets = {},
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },

    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<TAB>'] = cmp.mapping(function (fallback)
        if cmp.visible() then
          cmp.confirm({ select = true })
        else
          fallback()
        end
      end, { 'i', 's'})
    }),

    sources = cmp.config.sources(
      {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        {
          name = 'async_path',
        },
        {
          name = 'latex_symbols',
          option = {
            strategy = 0,
          },
        },
      },

      {
        { name = 'buffer' },
      }
    ),
  })
end
