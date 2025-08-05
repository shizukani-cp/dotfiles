local manager = require("utils.manager")

manager.add({
    id = "bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim",
    dependencies = {
        "nvim-web-devicons",
    },
    config = function ()
        require("bufferline").setup()
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("bufferline.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("bufferline.nvim")
    end
})
