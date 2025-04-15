require("notify").setup({
    background_colour = "#000000",
})

local noice = require("noice")
noice.setup({
    routes = {
        {
            view = "notify",
            filter = { event = "msg_showmode" },
        },
    },
})
