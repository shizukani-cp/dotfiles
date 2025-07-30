local manager = require("utils.manager")

manager.add({
    id = "2048.nvim",
    url = "https://github.com/NStefan002/2048.nvim",
    config = function ()
        require("2048").setup({
            keys = {
                up = "<Up>",
                down = "<Down>",
                left = "<Left>",
                right = "<Right>",
            }
        })
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("2048.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("2048.nvim")
    end
})
