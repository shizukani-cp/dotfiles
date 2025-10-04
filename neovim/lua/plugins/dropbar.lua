local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "dropbar.nvim",
    url = "https://github.com/Bekaboo/dropbar.nvim",
    dependencies = {
        "nvim-web-devicons",
        "nvim-treesitter",
    },
    config = function ()
        require("dropbar").setup()
        vim.ui.select = require('dropbar.utils.menu').select
    end
})
lazyload.event("VimEnter", "dropbar.nvim")
