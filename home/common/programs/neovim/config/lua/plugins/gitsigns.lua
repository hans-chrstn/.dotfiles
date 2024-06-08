return {
  "lewis6991/gitsigns.nvim",
  config = function()
    vim.keymap.set("n", "<leader>gd", ":Gitsigns toggle_deleted<CR>", {})
    vim.keymap.set("n", "<leader>gn", ":Gitsigns toggle_numhl<CR>", {})
    vim.keymap.set("n", "<leader>gl", ":Gitsigns toggle_linehl<CR>", {})
    vim.keymap.set("n", "<leader>gw", ":Gitsigns toggle_word_diff<CR>", {})
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
