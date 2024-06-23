return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = {
		{
			"nvim-tree/nvim-web-devicons",
		},
	},
	config = function()
		require("dashboard").setup({
			theme = "hyper",
			config = {
				header = {
					[[╔────────────────────────────────────────────────────────────────────╗]],
					[[│                                                                    │]],
					[[│  ███▄ ▄███▓ ▄▄▄      ▓█████▄ ▓█████  ██▓     ██▓ ███▄    █ ▓█████  │]],
					[[│ ▓██▒▀█▀ ██▒▒████▄    ▒██▀ ██▌▓█   ▀ ▓██▒    ▓██▒ ██ ▀█   █ ▓█   ▀  │]],
					[[│ ▓██    ▓██░▒██  ▀█▄  ░██   █▌▒███   ▒██░    ▒██▒▓██  ▀█ ██▒▒███    │]],
					[[│ ▒██    ▒██ ░██▄▄▄▄██ ░▓█▄   ▌▒▓█  ▄ ▒██░    ░██░▓██▒  ▐▌██▒▒▓█  ▄  │]],
					[[│ ▒██▒   ░██▒ ▓█   ▓██▒░▒████▓ ░▒████▒░██████▒░██░▒██░   ▓██░░▒████▒ │]],
					[[│ ░ ▒░   ░  ░ ▒▒   ▓▒█░ ▒▒▓  ▒ ░░ ▒░ ░░ ▒░▓  ░░▓  ░ ▒░   ▒ ▒ ░░ ▒░ ░ │]],
					[[│ ░  ░      ░  ▒   ▒▒ ░ ░ ▒  ▒  ░ ░  ░░ ░ ▒  ░ ▒ ░░ ░░   ░ ▒░ ░ ░  ░ │]],
					[[│ ░      ░     ░   ▒    ░ ░  ░    ░     ░ ░    ▒ ░   ░   ░ ░    ░    │]],
					[[│        ░         ░  ░   ░       ░  ░    ░  ░ ░           ░    ░  ░ │]],
					[[│                       ░                                            │]],
					[[│                                                                    │]],
					[[╚────────────────────────────────────────────────────────────────────╝]],
				},
				shortcut = {
					{
						desc = "󰭎 Search",
						group = "Label",
						action = "Telescope find_files",
						key = "f",
					},
					{
						desc = "󰍉 Word Search",
						group = "Label",
						action = "Telescope live_grep",
						key = "l",
					},
					{
						desc = " Recent Files",
						group = "Label",
						action = "Telescope oldfiles",
						key = "o",
					},
					{
						desc = " New File",
						group = "Label",
						action = require("plugins.utils.create_new_file"),
						key = "n",
					},
					{
						desc = "󰩈 Exit",
						group = "Label",
						action = "q",
						key = "q",
					},
				},
				project = {
					enable = true,
					limit = 8,
					icon = " ",
					label = " Projects:",
					action = "Telescope find_files cwd=",
				},
				mru = {
					limit = 10,
					icon = " ",
					label = " Recently Used:",
					cwd_only = false,
				},
				packages = {
					enable = true,
				},
				footer = {},
			},
		})
	end,
}
