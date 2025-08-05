local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

manager.add({
    id = "ccc.nvim",
    url = "https://github.com/uga-rosa/ccc.nvim",
    config = function ()
        require("ccc").setup()
    end
})
set_keymap("n", "<Space>#", "<Cmd>CccPick<Cr>", "ccc.nvim", { noremap = true, silent = true, desc = "Color Pick" })
