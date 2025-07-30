local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

manager.add({
    id = "nvim-spectre",
    url = "https://github.com/nvim-pack/nvim-spectre",
    dependencies = {
        "plenary.nvim",
        "nvim-web-devicons"
    },
    config = function ()
        require("spectre").setup()
    end
})
set_keymap("n", "<Space>S", "<Cmd>lua require('spectre').toggle()<Cr>", "nvim-spectre", { noremap = true, silent = true, desc = "Toggle spectre" })
