local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "vimdoc-ja",
    url = "https://github.com/vim-jp/vimdoc-ja",
})
lazyload.event("VimEnter", "vimdoc-ja")
