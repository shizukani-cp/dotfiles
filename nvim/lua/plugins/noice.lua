return function(manager)
    manager:add({
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
    manager:lazyload_event("CmdLineEnter", "noice.nvim")
    manager:lazyload_event("SafeState", "noice.nvim")
end
