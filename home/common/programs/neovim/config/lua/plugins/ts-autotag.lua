return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact" }, -- Specify file types
  config = require('config.ts-autotag'),
}

