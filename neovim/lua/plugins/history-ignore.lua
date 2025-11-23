local lazyload = require("manager.lazyload")

local function config()
    require("history-ignore").setup()
end

return function(manager)
    manager.add({
        id = "history-ignore.nvim",
        url = "https://github.com/yutkat/history-ignore.nvim",
        config = config
    })
    lazyload.event("CmdLineEnter", "history-ignore.nvim")
end
