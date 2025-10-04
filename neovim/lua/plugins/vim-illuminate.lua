local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate",
})
lazyload.event("VimEnter", "vim-illuminate")
