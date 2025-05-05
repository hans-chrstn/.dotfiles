return function()
  require("trouble").setup({
    -- Add any configuration settings here
    -- For example, you can customize icons, signs, and other options
    auto_open = false,  -- Automatically open Trouble when there are diagnostics
    auto_close = true,  -- Automatically close Trouble when no diagnostics are present
    icons = {
      indent = {
        middle = " ",
        last = " ",
        top = " ",
        ws = "│  ",
      },
    },
    modes = {
      preview_float = {
        mode = "diagnostics",
        preview = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "Preview",
          title_pos = "center",
          position = { 0, -2 },
          size = { width = 0.3, height = 0.3 },
          zindex = 200,
        },
      },
    },
  })
end
