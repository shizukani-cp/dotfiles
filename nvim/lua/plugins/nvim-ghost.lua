local lazyload = require("manager.lazyload")

return function(manager)
    manager.add({
        id = "nvim-ghost",
        url = "https://github.com/subnut/nvim-ghost.nvim",
    })
    lazyload.event("BufWinEnter", "nvim-ghost")
end
