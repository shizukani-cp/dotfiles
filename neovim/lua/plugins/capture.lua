local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "capture.vim",
    url = "https://github.com/tyru/capture.vim",
})
lazyload.event("VimEnter", "capture.vim")
