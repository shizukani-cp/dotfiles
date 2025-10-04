local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim",
    config = function ()
        require("gitsigns").setup()
    end
})
lazyload.event("VimEnter", "gitsigns.nvim")
