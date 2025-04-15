-- Define a function to insert the header
local function insert_header()
    -- Get current date and time
    local current_datetime = os.date("%Y-%m-%d %H:%M:%S")

    -- Get current file type
    local filetype = vim.bo.filetype

    -- Define the header based on file type
    local header = ""
    if filetype == "sh" or filetype == "bash" then
        header = "#!/usr/bin/env bash\n" ..
                 "# Project:\n" ..
                 "# Description:\n" ..
                 "# Created by: Jake Pedersen\n" ..
                 "# Created on: " .. current_datetime .. "\n\n"
    end

    -- Insert the header at the beginning of the file
    vim.fn.append(0, header)
end

-- Define a mapping to trigger the function
vim.api.nvim_set_keymap('n', '<Space>sb', ':lua insert_header()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Space>b', ':w<CR>:!chmod +x %<CR>', { noremap = true })


