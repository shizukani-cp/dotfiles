local manager = require("utils.manager")

manager.add({
    id = "mason.nvim",
    url = "https://github.com/mason-org/mason.nvim",
    config = function ()
        require("mason").setup()
    end
})
