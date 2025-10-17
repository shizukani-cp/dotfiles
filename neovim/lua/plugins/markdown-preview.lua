local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim",
    config = function()
        vim.fn["mkdp#util#install"]()
        vim.g.mkdp_filetypes = { "markdown" }
    end
})

lazyload.event("FileType", "markdown-preview.nvim", "markdown")
