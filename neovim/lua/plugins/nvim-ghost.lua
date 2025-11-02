local lazyload = require("utils.lazyload")

return function(manager)
    manager.add({
        id = "nvim-ghost",
        url = "https://github.com/subnut/nvim-ghost.nvim",
    })
    lazyload.event("VimEnter", "nvim-ghost")
end
