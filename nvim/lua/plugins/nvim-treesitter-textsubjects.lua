local lazyload = require("manager.lazyload")

local function config()
    require('nvim-treesitter-textsubjects').configure({
        prev_selection = ',',
        keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
            ['i;'] = 'textsubjects-container-inner',
        },
    })
end

return function(manager)
    manager.add({
        id = "nvim-treesitter-textsubjects",
        url = "https://github.com/RRethy/nvim-treesitter-textsubjects",
        dependencies = {
            "nvim-treesitter",
        },
        config = config,
    })

    lazyload.event("BufWinEnter", "nvim-treesitter-textsubjects")
end
