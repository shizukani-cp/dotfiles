local lazyload = require("manager.lazyload")

local function config()
    require("manager.ui").setup()
end

return function(manager)
    manager.add({
        id = "manager-ui",
        url = "https://github.com/shizukani-cp/manager-ui",
        dependencies = {
            "manager-command",
        },
        dev = false,
        dir = require("utils.local_plugin_path")("manager-ui"),
        config = config,
    })
    lazyload.event("CmdLineEnter", "manager-ui")
    lazyload.event("BufWinEnter", "manager-ui")
end
