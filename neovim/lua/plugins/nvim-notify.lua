local manager = require("utils.manager")

manager.add({
    id = "nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify",
    config = function ()
        require("notify").setup()
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("nvim-notify_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("nvim-notify")
    end
})
