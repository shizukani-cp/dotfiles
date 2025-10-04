local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "history-ignore.nvim",
    url = "https://github.com/yutkat/history-ignore.nvim",
    config = function()
        require("history-ignore").setup()
    end
})
lazyload.event("VimEnter", "history-ignore.nvim")
