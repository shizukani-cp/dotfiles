local lazyload = require("manager.lazyload")

local function config()
    require("cmdline-hl").setup()
end

return function(manager)
    manager.add({
        id = "cmdline-hl.nvim",
        url = "https://github.com/Sam-programs/cmdline-hl.nvim",
        config = config
    })
    lazyload.event("CmdlineEnter", "cmdline-hl.nvim")
end
