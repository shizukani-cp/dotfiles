local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

manager.add({
    id = "registers.nvim",
    url = "https://github.com/tversteeg/registers.nvim",
    config = function()
        require("registers").setup()
    end
})
set_keymap("n", "<Space>R", "<Cmd>Registers<Cr>", "registers.nvim",
    { noremap = true, silent = true, desc = "Show Registers" })
