local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim",
    config = function()
        require("Comment").setup({
            toggler = {
                line = "<Leader>cc",
                block = "<Leader>cC",
            },
            opleader = {
                line = "<Leader>cc",
                block = "<Leader>cC",
            }
        })
    end
})
lazyload.event("VimEnter", "Comment.nvim")
