-- ~/.config/nvim/lua/my_cmp_config.lua
local cmp = require('cmp')

cmp.setup({
    max_items = 10,
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = " " .. vim_item.kind
            vim_item.menu = ({
                buffer = "[Buffer]",
                nvim_lsp = "[LSP]",
                ultisnips = "[UltiSnips]",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = 'buffer', priority = 1, keyword_length = 2 },
        { name = 'nvim_lsp', priority = 2 },
        { name = 'ultisnips', priority = 3 },
    },
    mapping = {
        ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
})

