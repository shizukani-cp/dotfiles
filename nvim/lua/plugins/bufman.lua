local lazyload = require("manager.lazyload")

local function config()
    require("bufman").setup()
end

return function(manager)
    manager.add({
        id = "bufman.nvim",
        url = "https://github.com/shizukani-cp/bufman.nvim",
        config = config,
    })
    lazyload.key("n", "<Leader>b", function()
        require("bufman").open()
    end, "bufman.nvim", { noremap = true, silent = true, desc = "Buffers" })
end
