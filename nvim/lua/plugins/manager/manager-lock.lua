local function config(manager)
    require("manager.lock").setup(manager, true)
end

return function(manager)
    manager:add({
        id = "manager-lock",
        url = "https://github.com/shizukani-cp/manager-lock",
        dev = false,
        dir = require("utils.local_plugin_path")("manager-lock"),
        config = config,
    })
    manager:load("manager-lock")
end
