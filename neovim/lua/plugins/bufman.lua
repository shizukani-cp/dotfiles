local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "bufman.nvim",
    url = "https://github.com/shizukani-cp/bufman.nvim",
    config = function()
        require("bufman").setup()
    end
})
lazyload.key("n", "<Leader>b", function()
    require("bufman").open()
end, "bufman.nvim", { noremap = true, silent = true, desc = "Buffers" })
