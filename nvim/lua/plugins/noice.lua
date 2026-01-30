local lazyload = require("manager.lazyload")

return function(manager)
    manager.add({
        id = "noice.nvim",
        url = "https://github.com/folke/noice.nvim",
        dependencies = {
            "nui.nvim",
            "nvim-treesitter",
        },
        config = function()
            require("noice").setup()
        end,
    })
    lazyload.event("CmdLineEnter", "noice.nvim")
    lazyload.event("BufWinEnter", "noice.nvim")
end
