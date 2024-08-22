return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"nix",
				"vim",
				"vimdoc",
				"lua",
				"javascript",
				"cpp",
				"c",
				"python",
				"bash",
				"rust",
				"typescript",
				"cmake",
				"css",
				"scss",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
