local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "noice.nvim",
    url = "https://github.com/folke/noice.nvim",
    dependencies = {
        "nui.nvim",
        "nvim-notify",
        "nvim-treesitter",
    },
    config = function ()
        require("noice").setup()
    end
})
lazyload.event("VimEnter", "noice.nvim")
