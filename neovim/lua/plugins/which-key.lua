local manager = require("utils.manager")

manager.add({
    id = "which-key.nvim",
    url = "https://github.com/folke/which-key.nvim",
    config = function()
        local wk = require("which-key")
        wk.setup()
        wk.register({
            p = { name = "Picker" }
        }, { prefix = "<Leader>" })
        wk.register({
            e = { name = "Editor" }
        }, { prefix = "<Leader>" })
        wk.register({
            c = { name = "Code" }
        }, { prefix = "<Leader>" })
    end
})
manager.load("which-key.nvim")
