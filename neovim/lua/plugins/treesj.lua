local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

manager.add({
    id = "treesj",
    url = "https://github.com/Wansmer/treesj",
    dependencies = {
        "nvim-treesitter"
    },
    config = function ()
        require("treesj").setup()
    end
})
set_keymap("n", "<Space>t", "<Cmd>lua require('treesj').toggle()<Cr>", "treesj", { noremap = true, silent = true, desc = "Split / Join" })
