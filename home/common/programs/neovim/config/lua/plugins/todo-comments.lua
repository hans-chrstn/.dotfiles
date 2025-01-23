return {
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufRead",
    config = require('config.todo-comments'),
  }
}
