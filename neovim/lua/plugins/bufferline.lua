local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim",
    dependencies = {
        "nvim-web-devicons",
    },
    config = function ()
        require("bufferline").setup()
    end
})
lazyload.event("VimEnter", "bufferline.nvim")
