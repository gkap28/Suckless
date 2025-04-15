-- Enable writebackup to make a backup before overwriting a file
vim.cmd('set writebackup')

-- Set backup directory to ~/.local/nvim/backup/
local backup_dir = vim.fn.expand('~/.local/nvim/backup/')
vim.cmd('set backupdir=' .. backup_dir)

-- Enable backup versions by appending .bkp to the file name
vim.cmd('set backupext=.bkp')

-- Define a function to prompt for backup and save accordingly
function SaveWithBackup()
    local choice = vim.fn.confirm("Do you want to create a backup?", "&Yes\n&No", 1)
    if choice == 1 then
        -- Create the backup directory if it doesn't exist
        vim.fn.mkdir(backup_dir, 'p')

        local backup_file = backup_dir .. vim.fn.expand('%:t:r') .. '.bkp'
        vim.cmd('write ' .. backup_file)
    elseif choice == 2 then
        vim.cmd('write')
    end
end

-- Define an autocommand to call the function before writing the file
vim.cmd([[
    augroup prompt_backup
        autocmd!
        autocmd BufWritePre * lua SaveWithBackup()
    augroup END
]])
