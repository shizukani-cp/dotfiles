local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "nvim-syntax-info",
    url = "https://github.com/wadackel/nvim-syntax-info",
})
lazyload.key("n", "<Leader>ci", "<Plug>(syntax-info-toggle)", "nvim-syntax-info",
    { noremap = true, silent = true, desc = "Syntax info" })
