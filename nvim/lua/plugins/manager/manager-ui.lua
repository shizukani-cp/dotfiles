local function config()
    require("manager.ui").setup()
end

return function(manager)
    manager:add({
        id = "manager-ui",
        url = "https://github.com/shizukani-cp/manager-ui",
        dependencies = {
            "manager-command",
        },
        dev = false,
        dir = require("utils.local_plugin_path")("manager-ui"),
        config = config,
    })
    manager:lazyload_event("CmdLineEnter", "manager-ui")
    manager:lazyload_event("BufWinEnter", "manager-ui")
end
