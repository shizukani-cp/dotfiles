local manager = require("utils.manager")

manager.add({
    id = "history-ignore.nvim",
    url = "https://github.com/yutkat/history-ignore.nvim",
    config = function()
        require("history-ignore").setup()
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("history-ignore.nvim_load", { clear = true }),
    pattern = "*",
    callback = function()
        manager.load("history-ignore.nvim")
    end
})
