local lazyload = require("manager.lazyload")

local function config()
    require("trouble").setup()
end

return function(manager)
    manager.add({
        id = "trouble.nvim",
        url = "https://github.com/folke/trouble.nvim",
        config = config
    })
    lazyload.key("n", "<Leader>cd", "<Cmd>Trouble diagnostics toggle<Cr>", "trouble.nvim",
        { noremap = true, silent = true, desc = "Diagnostics" })
end
