local lazyload = require("utils.lazyload")

local function config()
    require("fidget").setup()
end

return function(manager)
    manager.add({
        id = "fidget.nvim",
        url = "https://github.com/j-hui/fidget.nvim",
        config = config
    })
    lazyload.event("LspAttach", "fidget.nvim")
end
