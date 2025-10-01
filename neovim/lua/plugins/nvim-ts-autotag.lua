local manager = require("utils.manager")

manager.add({
    id = "nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag",
    config = function()
        require("nvim-ts-autotag").setup()
    end
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("nvim-ts-autotag_load", { clear = true }),
    pattern = "*",
    callback = function()
        manager.load("nvim-ts-autotag")
    end
})
