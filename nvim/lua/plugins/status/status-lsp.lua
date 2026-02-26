return function(manager)
    manager.add({
        id = "status-lsp",
        url = "https://github.com/shizukani-cp/status-lsp",
        dev = false,
        dir = require("utils.local_plugin_path")("status-lsp"),
    })
end
