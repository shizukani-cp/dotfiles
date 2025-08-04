local manager = require("utils.manager")

manager.add({
    id = "nvim-treesitter-context",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-context",
    dependencies = {
        "nvim-treesitter",
    },
    config = function ()
        require("treesitter-context").setup()
    end
})
manager.load("nvim-treesitter-context")
