local lazyload = require("manager.lazyload")

local function config()
    require("hlargs").setup()
    require("hlargs").enable()
end

return function(manager)
    manager.add({
        id = "hlargs.nvim",
        url = "https://github.com/m-demare/hlargs.nvim",
        config = config
    })

    lazyload.event("VimEnter", "hlargs.nvim")
end
