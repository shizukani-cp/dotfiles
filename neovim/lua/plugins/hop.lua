local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

manager.add({
    id = "hop.nvim",
    url = "https://github.com/smoka7/hop.nvim",
    config = function ()
        require("hop").setup({
            keys = 'etovxqpdygfblzhckisuran'
        })
    end
})
set_keymap("n", "f", "<Cmd>HopWord<Cr>", "hop.nvim", { noremap = true, silent = true, desc = "Go to any word in the current buffer." })
