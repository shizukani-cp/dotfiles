local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "numb.nvim",
    url = "https://github.com/nacro90/numb.nvim",
    config = function ()
        require("numb").setup()
    end
})
lazyload.event("VimEnter", "numb.nvim")
