local lazyload = require("manager.lazyload")

local function config()
    require("spectre").setup()
end

return function(manager)
    manager.add({
        id = "nvim-spectre",
        url = "https://github.com/nvim-pack/nvim-spectre",
        dependencies = {
            "plenary.nvim",
            "nvim-web-devicons"
        },
        config = config,
    })
    lazyload.key("n", "<Leader>cs", "<Cmd>lua require('spectre').toggle()<Cr>", "nvim-spectre",
        { noremap = true, silent = true, desc = "Spectre" })
end
