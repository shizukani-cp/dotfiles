local lazyload = require("manager.lazyload")

local function config()
    require("undotree").setup()
end

return function(manager)
    manager.add({
        id = "undotree",
        url = "https://github.com/jiaoshijie/undotree",
        dependencies = {
            "plenary.nvim",
        },
        config = config,
    })
    lazyload.key("n", "<Leader>eu", function()
        require("undotree").toggle()
    end, "undotree", { noremap = true, silent = true, desc = "Undo tree" })
end
