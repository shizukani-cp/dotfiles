local manager = require("utils.manager")

manager.add({
    id = "satellite.nvim",
    url = "https://github.com/lewis6991/satellite.nvim",
    config = function ()
        require("satellite").setup()
    end,
    dependencies = {
        "gitsigns.nvim"
    }
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("satellite.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("satellite.nvim")
    end
})
