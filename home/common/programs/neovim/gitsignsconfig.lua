return function()
  require("gitsigns").setup({
    signcolumn = false,
    numhl = false,
    linehl = false,
    word_diff = false,
    watch_gitdir = {
      follow_files = true,
    },
  })
end
