local manager = require("utils.manager")

manager.add({
    id = "capture.vim",
    url = "https://github.com/tyru/capture.vim",
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("capture.vim_load", { clear = true }),
    pattern = "*",
    callback = function()
        manager.load("capture.vim")
    end
})
