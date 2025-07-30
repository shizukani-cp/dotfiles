local manager = require("utils.manager")

manager.add({
    id = "wtf.nvim",
    url = "https://github.com/piersolenski/wtf.nvim",
    dependencies = {
        "plenary.nvim",
        "nui.nvim",
    },
    config = function ()
        require("wtf").setup()
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("wtf.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("wtf.nvim")
    end
})
