local manager = require("utils.manager")

manager.add({
    id = "hlchunk.nvim",
    url = "https://github.com/shellRaining/hlchunk.nvim",
    config = function ()
         require("hlchunk").setup({
            chunk = { enable = true, },
            indent = { enable = true, },
            blank = { enable = true, },
        })
    end
})
manager.load("hlchunk.nvim")
