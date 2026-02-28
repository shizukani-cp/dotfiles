return function(manager)
    manager:add({
        id = "ddu-source-manager",
        url = "https://github.com/shizukani-cp/ddu-source-manager",
        dev = false,
        dir = require("utils.local_plugin_path")("ddu-source-manager"),
    })
end
