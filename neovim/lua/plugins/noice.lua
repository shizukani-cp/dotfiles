local lazyload = require("manager.lazyload")

local function config()
    require("noice").setup()
end

return function(manager)
    manager.add({
        id = "noice.nvim",
        url = "https://github.com/folke/noice.nvim",
        dependencies = {
            "nui.nvim",
            "nvim-notify",
            "nvim-treesitter",
        },
        config = config
    })
    lazyload.event("VimEnter", "noice.nvim")
end
