local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "trouble.nvim",
    url = "https://github.com/folke/trouble.nvim",
    config = function()
        require("trouble").setup()
    end
})
lazyload.key("n", "<Leader>d", "<Cmd>Trouble diagnostics toggle<Cr>", "trouble.nvim",
    { noremap = true, silent = true, desc = "Diagnostics" })
