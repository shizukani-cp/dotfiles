local function config(manager)
    require("manager.remove").setup(manager)
end

return function(manager)
    manager:add({
        id = "manager-remove",
        url = "https://github.com/shizukani-cp/manager-remove",
        dev = false,
        dir = require("utils.local_plugin_path")("manager-remove"),
        config = config,
    })
    manager:lazyload_event("SafeState", "manager-remove")
end
