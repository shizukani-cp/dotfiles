local lazyload = require("manager.lazyload")

local function config()
    require("bufferline").setup()
end

return function(manager)
    manager.add({
        id = "bufferline.nvim",
        url = "https://github.com/akinsho/bufferline.nvim",
        dependencies = {
            "nvim-web-devicons",
        },
        config = config
    })
    lazyload.event("BufWinEnter", "bufferline.nvim")
end
