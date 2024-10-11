return function()
  require("nvim-ts-autotag").setup({
    enable = {
      close = true,  -- Auto close tags
      rename = true,  -- Auto rename pairs of tags
      close_on_slash = false, -- Auto close on trailing /
    },
  })
end
