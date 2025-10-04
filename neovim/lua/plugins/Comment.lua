local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim",
    config = function ()
        require("Comment").setup({
            toggler = {
                line = "<Space>c",
                block = "<Space>C",
            },
            opleader = {
                line = "<Space>c",
                block = "<Space>C",
            }
        })
    end
})
lazyload.event("VimEnter", "Comment.nvim")
