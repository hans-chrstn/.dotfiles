return function()
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")
  local open_with_trouble = require("trouble.sources.telescope").open

  telescope.setup({
    defaults = {
      mappings = {
        i = { ["<c-t>"] = open_with_trouble },
        n = { ["<c-t>"] = open_with_trouble },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = false,
        override_file_sorter = true,
      },
      media_files = {
        filetypes = { "png", "jpg", "mp4", "webm" },
        find_cmd = "rg",
      },
      ["ui-select"] = {
        require("telescope.themes").get_dropdown({}),
      },
    },
  })

  telescope.load_extension("ui-select")

  -- Key mappings for telescope commands
  vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
  vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "List Buffers" })
  vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
end
