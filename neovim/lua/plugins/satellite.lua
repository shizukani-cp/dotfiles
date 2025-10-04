local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "satellite.nvim",
    url = "https://github.com/lewis6991/satellite.nvim",
    config = function ()
        require("satellite").setup()
    end,
    dependencies = {
        "gitsigns.nvim"
    }
})
lazyload.event("VimEnter", "satellite.nvim")
