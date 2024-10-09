return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
  event = "BufReadPost",
	config = function()
		require("nvim-treesitter.configs").setup({
			-- ensure_installed = {
			-- 	-- "nix",
			-- 	-- "vim",
			-- 	-- "vimdoc",
			-- 	-- "lua",
			-- 	-- "javascript",
			-- 	-- "cpp",
			-- 	-- "c",
			-- 	-- "python",
			-- 	-- "bash",
			-- 	-- "rust",
			-- 	-- "typescript",
			-- 	-- "cmake",
			-- 	-- "css",
			-- 	-- "scss",
   --      -- "kotlin",
			-- },
			sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
			indent = { enable = true },
		})
	end,
}
