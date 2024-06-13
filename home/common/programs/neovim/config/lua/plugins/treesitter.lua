return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufRead",
  config = function() 
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "cpp", "lua", "javascript" },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },  
    })
  end
}
