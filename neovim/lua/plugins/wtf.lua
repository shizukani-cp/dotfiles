local lazyload = require("manager.lazyload")

local function config()
    require("wtf").setup()
end

return function(manager)
    manager.add({
        id = "wtf.nvim",
        url = "https://github.com/piersolenski/wtf.nvim",
        dependencies = {
            "plenary.nvim",
            "nui.nvim",
        },
        config = config
    })
    lazyload.event("VimEnter", "wtf.nvim")
end
