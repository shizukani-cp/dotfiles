local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs",
    config = function ()
        require("nvim-autopairs").setup()
    end
})
lazyload.event("InsertEnter", "nvim-autopairs")
