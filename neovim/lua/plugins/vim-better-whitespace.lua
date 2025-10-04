local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "vim-better-whitespace",
    url = "https://github.com/ntpeters/vim-better-whitespace",
})

lazyload.event("VimEnter", "vim-better-whitespace")
