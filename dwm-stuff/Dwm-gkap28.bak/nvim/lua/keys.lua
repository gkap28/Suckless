vim.keymap.set("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>")
vim.keymap.set("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fb", "<CMD>Telescope file_browser<CR>")
vim.keymap.set("n", "<leader>fw", "<CMD>Telescope live_grep<CR>")
vim.keymap.set("n", "<leader>ht", "<CMD>Telescope colorscheme<CR>")
-- Open a terminal at the bottom 25% of the buffer
vim.api.nvim_set_keymap('n', '<leader>t', ':botright 25split term://bash<CR>i clear<CR>', { noremap = true, silent = true })


vim.api.nvim_set_keymap('n', '<Leader>sz', [[:lua require'utils'.insert_shebang()<CR>]], { noremap = true, silent = true })

function _G.insert_shebang()
    local shebang = "#!/usr/bin/env bash\n\nCreated By: Jake@Linux\n" ..
                    "# Created On: " .. os.date('%c') .. "\n\n# Project: "
    vim.api.nvim_put({ shebang }, '', true, true)
end

vim.keymap.set("i", '<C-h>', "<Left>", {})
vim.keymap.set("i", '<C-l>', "<Right>", {})
vim.keymap.set("i", '<C-j>', "<DOWN>", {})
vim.keymap.set("i", '<C-k>', "<UP>", {})

-- Clear search highlighting
vim.keymap.set('n', '<leader><space>', ':nohlsearch<CR>', { noremap = true, silent = true })
-- reload config
vim.keymap.set('n', '<leader>rs', ':source %<CR>', { noremap = true, silent = true })
