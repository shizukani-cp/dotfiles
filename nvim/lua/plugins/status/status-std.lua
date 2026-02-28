return function(manager)
    manager:add({
        id = "status-std",
        url = "https://github.com/shizukani-cp/status-std",
        dev = false,
        dir = require("utils.local_plugin_path")("status-std"),
    })
end
