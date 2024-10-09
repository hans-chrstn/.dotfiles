return {
  "windwp/nvim-ts-autotag",
  event = { "BufReadPre", "BufNewFile" },
  ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact" }, -- Specify file types
  config = function()
    require("nvim-ts-autotag").setup({
      enable = {
        close = true,  -- Auto close tags
        rename = true,  -- Auto rename pairs of tags
        close_on_slash = false, -- Auto close on trailing /
      },
    })
  end,
}

