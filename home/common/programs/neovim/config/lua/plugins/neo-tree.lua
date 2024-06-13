return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  event = "BufReadPost",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", {})
    require("neo-tree").setup({})
  end
}
