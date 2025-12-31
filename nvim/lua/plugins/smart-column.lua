local lazyload = require("manager.lazyload")

local function config()
    require("smartcolumn").setup()
end

return function(manager)
    manager.add({
        id = "smart-column.nvim",
        url = "https://github.com/m4xshen/smartcolumn.nvim",
        config = config,
    })
    lazyload.event("BufWinEnter", "smart-column.nvim")
end
