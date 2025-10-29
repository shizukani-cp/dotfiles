local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "nvim-surround",
    url = "https://github.com/kylechui/nvim-surround",
    config = function()
        require("nvim-surround").setup()
    end
})

lazyload.event("VimEnter", "nvim-surround")
