local lazyload = require("manager.lazyload")

local function config()
    require("manager.command").setup()
end

return function(manager)
    manager.add({
        id = "manager-command",
        url = "https://github.com/shizukani-cp/manager-command",
        config = config,
    })
    lazyload.event("CmdLineEnter", "manager-command")
end
