local lazyload = require("utils.lazyload")

local function config()
    require("2048").setup({
        keys = {
            up = "<Up>",
            down = "<Down>",
            left = "<Left>",
            right = "<Right>",
        }
    })
end

return function(manager)
    manager.add({
        id = "2048.nvim",
        url = "https://github.com/NStefan002/2048.nvim",
        config = config,
    })
    lazyload.event("VimEnter", "2048.nvim")
end
