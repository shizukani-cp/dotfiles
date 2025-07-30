local manager = require("utils.manager")

manager.add({
    id = "numb.nvim",
    url = "https://github.com/nacro90/numb.nvim",
    config = function ()
        require("numb").setup()
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("numb.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("numb.nvim")
    end
})
