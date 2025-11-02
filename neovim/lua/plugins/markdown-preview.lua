local lazyload = require("utils.lazyload")

local function config()
    vim.fn["mkdp#util#install"]()
    vim.g.mkdp_filetypes = { "markdown" }
end

return function(manager)
    manager.add({
        id = "markdown-preview.nvim",
        url = "https://github.com/iamcco/markdown-preview.nvim",
        config = config,
    })

    lazyload.event("FileType", "markdown-preview.nvim", "markdown")
end
