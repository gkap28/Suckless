local g = vim.g
local o = vim.o
local opt = vim.opt

g.mapleader = ' '
g.maplocalleader = ' '

o.clipboard = 'unnamedplus'

o.scrolloff = 8

o.number = true
o.numberwidth = 2
o.relativenumber = true

o.signcolumn = "no"
o.cursorline = true

o.tabstop = 4
o.shiftwidth = 4

o.updatetime = 300

o.termguicolors = true

o.mouse = 'a'

o.ignorecase = true
o.smartcase = true

o.history = 50

o.splitright = true
o.splitbelow = true

o.expandtab = true
o.smarttab = true

o.cindent = true
o.autoindent = true

o.wrap = false
o.textwidth = 170
o.linebreak = true
o.breakindent = true

o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = true
o.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"

o.spelllang = 'en_us'
o.spell = true

o.undofile = true
o.undodir = "/home/jake/.local/nvim/undo"
