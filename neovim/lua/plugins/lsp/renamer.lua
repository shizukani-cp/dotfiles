local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "renamer.nvim",
    url = "https://github.com/filipdutescu/renamer.nvim",
    dependencies = {
        "plenary.nvim"
    },
    config = function()
        require("renamer").setup()
    end
})

lazyload.key({ "n", "v" }, "<Leader>cr", "<Cmd>lua require('renamer').rename()<Cr>", "renamer.nvim",
    { noremap = true, silent = true, desc = "Rename symbol" })
