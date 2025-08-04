local manager = require("utils.manager")

manager.add({
    id = "dropbar.nvim",
    url = "https://github.com/Bekaboo/dropbar.nvim",
    dependencies = {
        "nvim-web-devicons",
        "nvim-treesitter",
    },
    config = function ()
        require("dropbar").setup()
        vim.ui.select = require('dropbar.utils.menu').select
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("dropbar.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("dropbar.nvim")
    end
})
