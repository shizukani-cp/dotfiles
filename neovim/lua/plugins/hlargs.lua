local manager = require("utils.manager")

manager.add({
    id = "hlargs.nvim",
    url = "https://github.com/m-demare/hlargs.nvim",
    config = function()
        require("hlargs").setup()
        require("hlargs").enable()
    end
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("hlargs.nvim_load", { clear = true }),
    pattern = "*",
    callback = function()
        manager.load("hlargs.nvim")
    end
})
