local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap


manager.add({
    id = "lspsaga.nvim",
    url = "https://github.com/nvimdev/lspsaga.nvim",
    config = function ()
        require("lspsaga").setup({
            lightbulb = { enabled = false }
        })
    end
})
set_keymap("n", "<space>r", "<Cmd>Lspsaga rename<CR>", "lspsaga.nvim", { noremap = true, silent = true, desc = "Rename symbol" })
