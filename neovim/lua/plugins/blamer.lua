local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

manager.add({
    id = "blamer.nvim",
    url = "https://github.com/APZelos/blamer.nvim",
    config = function ()
        vim.g.blamer_enabled = false
        vim.g.blamer_date_format = '%y/%m/%d'
    end
})
set_keymap("n", "<Space>B", "<Cmd>BlamerToggle<Cr>", "blamer.nvim", { noremap = true, silent = true, desc = "Show Blame" })
