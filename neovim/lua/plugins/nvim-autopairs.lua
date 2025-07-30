local manager = require("utils.manager")

manager.add({
    id = "nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs",
    config = function ()
        require("nvim-autopairs").setup()
    end
})
vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("nvim-autopairs_load", { clear = true }),
    pattern = "*",
    callback = function()
        manager.load("nvim-autopairs")
    end,
})
