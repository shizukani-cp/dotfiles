return function(manager)
    manager:add({
        id = "vist-file",
        url = "https://github.com/shizukani-cp/vist-file",
        dependencies = {
            "nvim-web-devicons",
        },
        dev = false,
        dir = require("utils.local_plugin_path")("vist-file"),
    })
end
