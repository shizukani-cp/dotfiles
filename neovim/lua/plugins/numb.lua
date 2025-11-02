local lazyload = require("utils.lazyload")

local function config()
    require("numb").setup()
end

return function(manager)
    manager.add({
        id = "numb.nvim",
        url = "https://github.com/nacro90/numb.nvim",
        config = config,
    })
    lazyload.event("VimEnter", "numb.nvim")
end
