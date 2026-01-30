local lazyload = require("manager.lazyload")

local function config()
    require("dropbar").setup()
    vim.ui.select = require("dropbar.utils.menu").select
end

return function(manager)
    manager.add({
        id = "dropbar.nvim",
        url = "https://github.com/Bekaboo/dropbar.nvim",
        dependencies = {
            "nvim-web-devicons",
            "nvim-treesitter",
        },
        config = config,
    })
    lazyload.event("BufWinEnter", "dropbar.nvim")
end
