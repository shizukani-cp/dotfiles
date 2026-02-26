return function(manager)
    manager.add({
        id = "status-git",
        url = "https://github.com/shizukani-cp/status-git",
        dependencies = {
            "gitsigns.nvim",
        },
        dev = false,
        dir = require("utils.local_plugin_path")("status-git"),
    })
end
