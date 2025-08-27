local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

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
set_keymap("n", "<Space>u", function() require('undotree').toggle() end, "undotree", { noremap = true, silent = true, desc = "Show undo tree" })
