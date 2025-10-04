local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim",
    config = function ()
        require("fidget").setup()
    end
})
lazyload.event("LspAttach", "fidget.nvim")
