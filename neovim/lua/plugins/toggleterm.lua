local manager = require("utils.manager")

manager.add({
    id = "toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim",
    config = function ()
        require("toggleterm").setup({
            open_mapping = [[<C-_>]],
            hide_numbers = true,
            close_on_exit = true,
            direction = "tab"
        })
    end
})
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("toggleterm.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("toggleterm.nvim")
    end
})
