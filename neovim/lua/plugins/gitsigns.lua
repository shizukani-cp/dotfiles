local lazyload = require("manager.lazyload")

local function config()
    require("gitsigns").setup()
end

return function(manager)
    manager.add({
        id = "gitsigns.nvim",
        url = "https://github.com/lewis6991/gitsigns.nvim",
        config = config,
    })
    lazyload.event("BufReadPost", "gitsigns.nvim")
end
