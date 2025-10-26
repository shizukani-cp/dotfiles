local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "sort.nvim",
    url = "https://github.com/sQVe/sort.nvim",
    config = function()
        require("sort").setup()
    end
})
lazyload.event("VimEnter", "sort.nvim")
