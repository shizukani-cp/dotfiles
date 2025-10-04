local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "ccc.nvim",
    url = "https://github.com/uga-rosa/ccc.nvim",
    config = function ()
        require("ccc").setup()
    end
})
lazyload.key("n", "<Space>#", "<Cmd>CccPick<Cr>", "ccc.nvim", { noremap = true, silent = true, desc = "Color Pick" })
