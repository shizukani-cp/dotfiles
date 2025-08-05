local manager = require("utils.manager")

manager.add({
    id = "vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate",
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("vim-illuminate_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("vim-illuminate")
    end
})
