local lazyload = require("manager.lazyload")

local function config()
    vim.g.blamer_enabled = false
    vim.g.blamer_date_format = '%y/%m/%d'
end

return function(manager)
    manager.add({
        id = "blamer.nvim",
        url = "https://github.com/APZelos/blamer.nvim",
        config = config
    })
    lazyload.key("n", "<Leader>cb", "<Cmd>BlamerToggle<Cr>", "blamer.nvim",
        { noremap = true, silent = true, desc = "Blame" })
end
