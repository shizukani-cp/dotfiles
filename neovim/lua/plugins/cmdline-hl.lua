local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "cmdline-hl.nvim",
    url = "https://github.com/Sam-programs/cmdline-hl.nvim",
    config = function ()
        require("cmdline-hl").setup()
    end
})
lazyload.event("CmdlineEnter", "cmdline-hl.nvim")
