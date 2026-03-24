return function(manager)
    manager:add({
        id = "vist.nvim",
        url = "https://github.com/shizukani-cp/vist.nvim",
        dependencies = {
            "vist-file",
        },
        dev = false,
        dir = require("utils.local_plugin_path")("vist.nvim"),
    })
    manager:lazyload_key("n", "<Leader>f", function()
        require("vist.core").open(require("vist.file"))
    end, "vist.nvim", { noremap = true, silent = true, desc = "file" })
end
