local lazyload = require("manager.lazyload")

local function config()
    require("nvim-ts-autotag").setup()
end

return function(manager)
    manager.add({
        id = "nvim-ts-autotag",
        url = "https://github.com/windwp/nvim-ts-autotag",
        config = config,
    })

    lazyload.event("VimEnter", "nvim-ts-autotag")
end
