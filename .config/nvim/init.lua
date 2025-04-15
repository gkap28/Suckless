require "options"
require "plugins"
require "keys"
require "backup"
require "cmpConf"
require "notifyConf"
require "header"

require("lualine").setup({
  sections = {
    lualine_x = {
      {
        require("noice").api.statusline.mode.get,
        cond = require("noice").api.statusline.mode.has,
        color = { fg = "#ff9e64" },
      }
    },
  },
})
