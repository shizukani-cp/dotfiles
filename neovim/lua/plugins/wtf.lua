local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "wtf.nvim",
    url = "https://github.com/piersolenski/wtf.nvim",
    dependencies = {
        "plenary.nvim",
        "nui.nvim",
    },
    config = function ()
        require("wtf").setup()
    end
})
lazyload.event("VimEnter", "wtf.nvim")
