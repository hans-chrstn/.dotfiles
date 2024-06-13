local function create_new_file()
    -- Prompt the user for the filename
    local filename = vim.fn.input("Enter filename: ")
    -- Check if the filename is empty
    if filename ~= "" then
        -- Use Vim's `edit` command to create a new file
        vim.cmd("edit " .. filename)
    else
        print("Filename cannot be empty")
    end
end

return create_new_file
