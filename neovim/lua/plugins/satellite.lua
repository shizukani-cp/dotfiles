local lazyload = require("utils.lazyload")

local function config()
    require("satellite").setup()
end

return function(manager)
    manager.add({
        id = "satellite.nvim",
        url = "https://github.com/lewis6991/satellite.nvim",
        dependencies = {
            "gitsigns.nvim"
        },
        config = config,
    })
    lazyload.event("VimEnter", "satellite.nvim")
end
