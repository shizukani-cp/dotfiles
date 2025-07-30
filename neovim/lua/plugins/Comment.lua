local manager = require("utils.manager")

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
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("Comment.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("Comment.nvim")
    end
})
