local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

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
lazyload.key("n", "<Space>t", "<Cmd>lua require('treesj').toggle()<Cr>", "treesj", { noremap = true, silent = true, desc = "Split / Join" })
