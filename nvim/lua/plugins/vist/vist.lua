return function(manager)
    manager:add({
        id = "vist.nvim",
        url = "https://github.com/shizukani-cp/vist.nvim",
        dev = false,
        dir = require("utils.local_plugin_path")("vist.nvim"),
    })
end
