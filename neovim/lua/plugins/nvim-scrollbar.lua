local manager = require("utils.manager")

manager.add({
    id = "nvim-scrollbar",
    url = "https://github.com/petertriho/nvim-scrollbar",
    config = function ()
        require("scrollbar").setup({})
    end
})
