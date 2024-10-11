return function()
  -- Set colorscheme first to avoid flickering
  vim.cmd("colorscheme catppuccin-mocha")

  -- Defer the rest of the setup to ensure smoother transition
  vim.defer_fn(function()
    require("catppuccin").setup({
      term_colors = true,
      integrations = {
        treesitter = true,
        gitsigns = true,
        telescope = true,
        neotree = true,
        dashboard = true,
        bufferline = true,
      }
    })
  end, 10)  -- 10ms delay to ensure smoother UI transition
end
