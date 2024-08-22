return {
	"numToStr/Comment.nvim",
	lazy = false,
	config = function()
		require("Comment").setup({
			padding = true,
			sticky = true,
			ignore = nil,
			toggler = {
				line = "gcc",
				block = "gbc",
			},

			opleader = {
				line = "gc",
				block = "gb",
			},

			extra = {
				above = "gc0",
				below = "gco",
				eol = "gcA",
			},

			mappings = {
				basic = true,
				extra = true,
			},

			pre_hook = nil,
			post_hook = nil,
		})
	end,
}
