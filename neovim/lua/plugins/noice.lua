local manager = require("utils.manager")

manager.add({
    id = "noice.nvim",
    url = "https://github.com/folke/noice.nvim",
    dependencies = {
        "nui.nvim",
        "nvim-notify",
        "nvim-treesitter",
    },
    config = function ()
        require("noice").setup()
    end
})
vim.api.nvim_create_autocmd("CmdlineEnter", {
    group = vim.api.nvim_create_augroup("noice.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("noice.nvim")
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("nvim-notify_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("nvim-notify")
    end
})
