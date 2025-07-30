local manager = require("utils.manager")

manager.add({
    id = "oil-git-signs.nvim",
    url = "https://github.com/FerretDetective/oil-git-signs.nvim",
    dependencies = {
        "oil.nvim"
    },
    config = function()
        require("oil-git-signs").setup()
    end
})
