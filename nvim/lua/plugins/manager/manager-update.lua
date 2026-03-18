local function config(manager)
    require("manager.update").setup(manager)
end

return function(manager)
    manager:add({
        id = "manager-update",
        url = "https://github.com/shizukani-cp/manager-update",
        dev = false,
        dir = require("utils.local_plugin_path")("manager-update"),
        config = config,
    })
    manager:lazyload_event("SafeState", "manager-update")
end
