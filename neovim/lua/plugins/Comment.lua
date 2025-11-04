local lazyload = require("utils.lazyload")

local function config()
    require("Comment").setup({
        toggler = {
            line = "<Leader>cc",
            block = "<Leader>cC",
        },
        opleader = {
            line = "<Leader>c",
            block = "<Leader>C",
        }
    })
end

return function(manager)
    manager.add({
        id = "Comment.nvim",
        url = "https://github.com/numToStr/Comment.nvim",
        config = config
    })
    lazyload.event("VimEnter", "Comment.nvim")
end
