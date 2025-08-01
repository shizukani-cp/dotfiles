local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

manager.add({
    id = "oil.nvim",
    url = "https://github.com/stevearc/oil.nvim",
    dependencies = {
        "nvim-web-devicons",
    },
    config = function ()
        require("oil").setup({
            win_options = {
                signcolumn = "yes:2",
                statuscolumn = "",
            },
            view_options = {
                show_hidden = true,
            },
        })
    end
})
set_keymap("n", "<Space>f", "<cmd>Oil<CR>", "oil-git-signs.nvim", { noremap = true, silent = true, desc = "Open oil buffer" })
