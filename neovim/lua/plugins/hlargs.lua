local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "hlargs.nvim",
    url = "https://github.com/m-demare/hlargs.nvim",
    config = function()
        require("hlargs").setup()
        require("hlargs").enable()
    end
})

lazyload.event("VimEnter", "hlargs.nvim")
