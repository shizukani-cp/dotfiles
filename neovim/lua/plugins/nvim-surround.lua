local lazyload = require("manager.lazyload")

local function config()
    require("nvim-surround").setup()
end

return function(manager)
    manager.add({
        id = "nvim-surround",
        url = "https://github.com/kylechui/nvim-surround",
        config = config
    })

    lazyload.event("VimEnter", "nvim-surround")
end
