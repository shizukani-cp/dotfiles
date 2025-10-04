local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag",
    config = function()
        require("nvim-ts-autotag").setup()
    end
})

lazyload.event("VimEnter", "nvim-ts-autotag")
