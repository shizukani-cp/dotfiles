local manager = require("utils.manager")

manager.add({
    id = "nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify",
    config = function ()
        require("notify").setup()
    end
})
manager.load("nvim-notify")
