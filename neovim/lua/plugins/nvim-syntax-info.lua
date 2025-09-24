local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

manager.add({
    id = "nvim-syntax-info",
    url = "https://github.com/wadackel/nvim-syntax-info",
})
set_keymap("n", "<Space>i", "<Plug>(syntax-info-toggle)", "nvim-syntax-info",
    { noremap = true, silent = true, desc = "Toggle syntax info" })
