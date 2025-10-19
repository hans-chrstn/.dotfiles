return function()
  local markdown = require('render-markdown')
  markdown.setup({
    latex = { enabled = false }
  })
end
