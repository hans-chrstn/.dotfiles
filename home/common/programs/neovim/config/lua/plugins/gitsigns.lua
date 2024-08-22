return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPost",
  keys = {
    { "<leader>gd", "<cmd>Gitsigns toggle_deleted<CR>", desc = "Show deleted files" },
    { "<leader>gn", "<cmd>Gitsigns toggle_numhl<CR>", desc = "Show numhl" },
    { "<leader>gl", "<cmd>Gitsigns toggle_linehl<CR>", desc = "Show linehl" },
    { "<leader>gw", "<cmd>Gitsigns toggle_word_diff<CR>", desc = "Show word diff" },
  },
  config = function()
    require("gitsigns").setup({
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        follow_files = true,
      },
    })
  end
}
