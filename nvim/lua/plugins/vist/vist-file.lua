return function(manager)
    manager:add({
        id = "vist-file",
        url = "https://github.com/shizukani-cp/vist-file",
        dependencies = {
            "nvim-web-devicons",
            "vist.nvim",
        },
        dev = false,
        dir = require("utils.local_plugin_path")("vist-file"),
    })
    manager:lazyload_key("n", "<Leader>h", function()
        require("vist.core").open(require("vist.file"))
    end, "vist-file", { noremap = true, silent = true, desc = "file" })
end
