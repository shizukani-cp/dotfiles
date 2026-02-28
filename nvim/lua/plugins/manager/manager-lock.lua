return function(manager)
    manager:add({
        id = "manager-lock",
        url = "https://github.com/shizukani-cp/manager-lock",
        dev = false,
        dir = require("utils.local_plugin_path")("manager-lock"),
    })
    manager:load("manager-lock")
end
