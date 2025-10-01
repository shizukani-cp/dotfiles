local manager = require("utils.manager")

manager.add({
    id = "indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim",
    config = function()
        require("ibl").setup()
    end
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("indent-blankline.nvim_load", { clear = true }),
    pattern = "*",
    callback = function()
        manager.load("indent-blankline.nvim")
    end
})
