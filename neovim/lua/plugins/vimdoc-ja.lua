local manager = require("utils.manager")

manager.add({
    id = "vimdoc-ja",
    url = "https://github.com/vim-jp/vimdoc-ja",
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("vimdoc-ja_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("vimdoc-ja")
    end
})
