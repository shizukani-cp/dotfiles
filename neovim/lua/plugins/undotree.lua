local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "undotree",
    url = "https://github.com/jiaoshijie/undotree",
    dependencies = {
        "plenary.nvim",
    },
    config = function()
        require('undotree').setup()
    end,
})
lazyload.key("n", "<Leader>u", function() require('undotree').toggle() end, "undotree",
    { noremap = true, silent = true, desc = "Undo tree" })
