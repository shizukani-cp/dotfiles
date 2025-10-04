local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "blamer.nvim",
    url = "https://github.com/APZelos/blamer.nvim",
    config = function()
        vim.g.blamer_enabled = false
        vim.g.blamer_date_format = '%y/%m/%d'
    end
})
lazyload.key("n", "<Leader>b", "<Cmd>BlamerToggle<Cr>", "blamer.nvim",
    { noremap = true, silent = true, desc = "Show Blame" })
