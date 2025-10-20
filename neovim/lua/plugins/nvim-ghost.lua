local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "nvim-ghost",
    url = "https://github.com/subnut/nvim-ghost.nvim",
})
lazyload.event("VimEnter", "nvim-ghost")
