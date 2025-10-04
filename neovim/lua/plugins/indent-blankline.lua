local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim",
    config = function()
        require("ibl").setup()
    end
})

lazyload.event("VimEnter", "indent-blankline.nvim")
