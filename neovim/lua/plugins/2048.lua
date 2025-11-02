local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "2048.nvim",
    url = "https://github.com/NStefan002/2048.nvim",
    config = function()
        require("2048").setup({
            keys = {
                up = "<Up>",
                down = "<Down>",
                left = "<Left>",
                right = "<Right>",
            }
        })
    end
})
lazyload.event("VimEnter", "2048.nvim")
