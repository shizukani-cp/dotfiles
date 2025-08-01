local manager = require("utils.manager")

manager.add({
    id = "gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim",
    dependencies = { "nvim-scrollbar" },
    config = function ()
        require("gitsigns").setup()
        require("scrollbar.handlers.gitsigns").setup()
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("gitsigns.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("gitsigns.nvim")
    end
})
