local manager = require("utils.manager")

manager.add({
    id = "reglist.nvim",
    url = "https://github.com/shizukani-cp/reglist.nvim",
    config = function ()
        require("reglist").setup()
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("reglist.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("reglist.nvim")
    end
})
