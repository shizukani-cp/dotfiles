return function(manager)
    manager:add({
        id = "manager-lazyload",
        url = "https://github.com/shizukani-cp/manager-lazyload",
        dev = false,
        dir = require("utils.local_plugin_path")("manager-lazyload"),
    })
    manager:load("manager-lazyload")
end
