local function config(manager)
    require("manager.lazyload").setup(manager)
end

return function(manager)
    manager:add({
        id = "manager-lazyload",
        url = "https://github.com/shizukani-cp/manager-lazyload",
        dev = false,
        dir = require("utils.local_plugin_path")("manager-lazyload"),
        config = config,
    })
    manager:load("manager-lazyload")
end
