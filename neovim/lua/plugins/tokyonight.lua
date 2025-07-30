local manager = require("utils.manager")

manager.add({
    id = "tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim",
    config = function ()
        vim.cmd[[colorscheme tokyonight]]
    end,
})
manager.load("tokyonight.nvim")
