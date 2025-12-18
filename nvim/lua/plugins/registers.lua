local lazyload = require("manager.lazyload")

local function config()
    require("registers").setup()
end

return function(manager)
    manager.add({
        id = "registers.nvim",
        url = "https://github.com/tversteeg/registers.nvim",
        config = config
    })
    lazyload.key("n", "<Leader>er", "<Cmd>Registers<Cr>", "registers.nvim",
        { noremap = true, silent = true, desc = "Registers" })
end
