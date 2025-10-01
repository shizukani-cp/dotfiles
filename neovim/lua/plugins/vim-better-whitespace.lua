local manager = require("utils.manager")

manager.add({
    id = "vim-better-whitespace",
    url = "https://github.com/ntpeters/vim-better-whitespace",
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("vim-better-whitespace_load", { clear = true }),
    pattern = "*",
    callback = function()
        manager.load("vim-better-whitespace")
    end
})
