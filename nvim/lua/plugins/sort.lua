local lazyload = require("manager.lazyload")

local function config()
    require("sort").setup()
end

return function(manager)
    manager.add({
        id = "sort.nvim",
        url = "https://github.com/sQVe/sort.nvim",
        config = config,
    })
    lazyload.event("BufWinEnter", "sort.nvim")
end
