return function()
  require("trouble").setup({
    -- Add any configuration settings here
    -- For example, you can customize icons, signs, and other options
    auto_open = false,  -- Automatically open Trouble when there are diagnostics
    auto_close = true,  -- Automatically close Trouble when no diagnostics are present
  })
end
