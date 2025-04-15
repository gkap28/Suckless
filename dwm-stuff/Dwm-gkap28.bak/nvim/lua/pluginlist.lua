-- Plugin list for neovim


return {

    { 'numToStr/Comment.nvim', opts = {} },

    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end
    },
    -- Lua
    { 
        'jdpedersen1/poimandres.nvim',
        lazy = false,
        priority = 1000,
        enabled = true,
        config = function()
            require('poimandres').setup {
                -- leave this setup function empty for default config
                -- or refer to the configuration section
                -- for configuration options
            }
        end,

        -- optionally set the colorscheme within lazy config
        init = function()
            vim.cmd("colorscheme poimandres")
            vim.cmd([[ hi Normal guibg=NONE ctermbg=NONE ]])
            vim.cmd([[ hi SignColumn guibg=NONE ctermbg=NONE ]])
            vim.cmd([[ hi VertSplit guibg=NONE ctermbg=NONE ]])
            vim.cmd([[ hi StatusLine guibg=NONE ctermbg=NONE ]])
            vim.cmd([[ hi StatusLineNC guibg=NONE ctermbg=NONE ]])

        end
    },

    {
        'kdheepak/monochrome.nvim',        
        lazy= false,
        priority = 1000,
        enabled = false,
        config = function()
            vim.cmd 'colorscheme monochrome'
            vim.cmd([[ hi Normal guibg=NONE ctermbg=NONE ]])
            vim.cmd([[ hi SignColumn guibg=NONE ctermbg=NONE ]])
            vim.cmd([[ hi VertSplit guibg=NONE ctermbg=NONE ]])
            vim.cmd([[ hi StatusLine guibg=NONE ctermbg=NONE ]])
            vim.cmd([[ hi StatusLineNC guibg=NONE ctermbg=NONE ]])

        end
    },

    {
        "stefanvanburen/rams",
        lazy = false,
        priority = 1000,
        enabled = false,
        dependencies = {
            "rktjmp/lush.nvim",
        },
        config = function()
            vim.cmd([[colorscheme rams]])
            vim.cmd([[ hi Normal guibg=NONE ctermbg=NONE ]])
            vim.cmd([[ hi SignColumn guibg=NONE ctermbg=NONE ]])
            vim.cmd([[ hi VertSplit guibg=NONE ctermbg=NONE ]])
            vim.cmd([[ hi StatusLine guibg=NONE ctermbg=NONE ]])
            vim.cmd([[ hi StatusLineNC guibg=NONE ctermbg=NONE ]])
        end,
    },



    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    'folke/neodev.nvim', -- new

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',

            'hrsh7th/cmp-nvim-lsp',

        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "javascript",
                    "typescript",
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    "elixir",
                    "erlang",
                    "heex",
                    "eex",
                    "java",
                    "kotlin",
                    "jq",
                    "dockerfile",
                    "json",
                    "html",
                    "terraform",
                    "go",
                    "tsx",
                    "bash",
                    "ruby",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = "<C-CR>",
                        node_decremental = "<bs>",
                    },
                },
            })
        end,    },


    { 
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' } 
    },

    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },


    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("lualine").setup({
                icons_enabled = true,
                theme = 'onedark',
            })
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },

    {
        "NvChad/nvim-colorizer.lua",
        lazy = false,
        priority = 1000,
        enabled = true,
        config = function()
            require("colorizer").setup {
                filetypes = { "*" },
                user_default_options = {
                    RGB = true, -- #RGB hex codes
                    RRGGBB = true, -- #RRGGBB hex codes
                    names = true, -- "Name" codes like Blue or blue
                    RRGGBBAA = false, -- #RRGGBBAA hex codes
                    AARRGGBB = false, -- 0xAARRGGBB hex codes
                    rgb_fn = false, -- CSS rgb() and rgba() functions
                    hsl_fn = false, -- CSS hsl() and hsla() functions
                    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    -- Available modes for `mode`: foreground, background,  virtualtext
                    mode = "background", -- Set the display mode.
                    -- Available methods are false / true / "normal" / "lsp" / "both"
                    -- True is same as normal
                    tailwind = false, -- Enable tailwind colors
                    -- parsers can contain values used in |user_default_options|
                    sass = { enable = false, parsers = { "css" }, }, -- Enable sass colors
                    virtualtext = "■",
                    -- update color values even if buffer is not focused
                    -- example use: cmp_menu, cmp_docs
                    always_update = false
                },
                -- all the sub-options of filetypes apply to buftypes
                buftypes = {},
            }  
        end
    },

    {
        'goolord/alpha-nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    };

    {
        'folke/noice.nvim',
       event = "VeryLazy",
        opts = {
          -- options
        },
        dependencies = {
            'MunifTanjim/nui.nvim',
            -- OPTIONAL nvim-notify
            'rcarriga/nvim-notify',
        }
    },

    {'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
            -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
            -- animation = true,
            -- insert_at_start = true,
            -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
        },
    },
    {
        '2kabhishek/tdo.nvim',
        dependencies =  'nvim-telescope/telescope.nvim',
        cmd = { 'Tdo', 'TdoEntry', 'TdoNote', 'TdoTodos', 'TdoToggle', 'TdoFind', 'TdoFiles' },
        keys = { '[t', ']t' },
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    },
}
