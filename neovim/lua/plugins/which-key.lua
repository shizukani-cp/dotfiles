local function config()
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
    wk.register({
        o = { name = "Overseer" }
    }, { prefix = "<Leader>" })
end


return function(manager)
    manager.add({
        id = "which-key.nvim",
        url = "https://github.com/folke/which-key.nvim",
        config = config
    })
    manager.load("which-key.nvim")
end
