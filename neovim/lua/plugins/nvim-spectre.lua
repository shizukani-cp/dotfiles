local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "nvim-spectre",
    url = "https://github.com/nvim-pack/nvim-spectre",
    dependencies = {
        "plenary.nvim",
        "nvim-web-devicons"
    },
    config = function()
        require("spectre").setup()
    end
})
lazyload.key("n", "<Leader>s", "<Cmd>lua require('spectre').toggle()<Cr>", "nvim-spectre",
    { noremap = true, silent = true, desc = "Toggle spectre" })
