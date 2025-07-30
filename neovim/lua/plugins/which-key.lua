local manager = require("utils.manager")

manager.add({
    id = "which-key.nvim",
    url = "https://github.com/folke/which-key.nvim",
    config = function ()
        require("which-key").setup()
    end
})
manager.load("which-key.nvim")
