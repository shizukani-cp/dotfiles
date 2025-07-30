local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

manager.add({
    id = "renamer.nvim",
    url = "https://github.com/filipdutescu/renamer.nvim",
    dependencies = {
        "plenary.nvim"
    },
    config = function ()
        require("renamer").setup()
    end
})

set_keymap({ "n", "v" }, "<Space>r", "<Cmd>lua require('renamer').rename()<Cr>", "renamer.nvim", { noremap = true, silent = true, desc = "Rename symbol" })
