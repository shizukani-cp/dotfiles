local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "visual-whitespace.nvim",
    url = "https://github.com/mcauley-penney/visual-whitespace.nvim",
    config = function()
        require("visual-whitespace").setup()
    end
})
lazyload.event("VimEnter", "visual-whitespace.nvim")
