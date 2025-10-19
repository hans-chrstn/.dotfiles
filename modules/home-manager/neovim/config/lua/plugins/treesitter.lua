return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
  event = "BufReadPost",
	config = require('config.treesitter'),
}
