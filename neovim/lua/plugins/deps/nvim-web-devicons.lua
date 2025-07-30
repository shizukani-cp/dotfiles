local manager = require("utils.manager")

manager.add({
    id = "nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons",
    config = function ()
        require("nvim-web-devicons").setup()
    end
})
