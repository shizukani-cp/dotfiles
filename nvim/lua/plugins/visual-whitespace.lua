local lazyload = require("manager.lazyload")

local function config()
    require("visual-whitespace").setup()
end

return function(manager)
    manager.add({
        id = "visual-whitespace.nvim",
        url = "https://github.com/mcauley-penney/visual-whitespace.nvim",
        config = config,
    })
    lazyload.event("BufWinEnter", "visual-whitespace.nvim")
end
