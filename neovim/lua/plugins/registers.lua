local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "registers.nvim",
    url = "https://github.com/tversteeg/registers.nvim",
    config = function()
        require("registers").setup()
    end
})
lazyload.key("n", "<Leader>er", "<Cmd>Registers<Cr>", "registers.nvim",
    { noremap = true, silent = true, desc = "Registers" })
