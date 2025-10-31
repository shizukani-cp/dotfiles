local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "nvim-treesitter-textsubjects",
    url = "https://github.com/RRethy/nvim-treesitter-textsubjects",
    dependencies = {
        "nvim-treesitter",
    },
    config = function()
        require('nvim-treesitter-textsubjects').configure({
            prev_selection = ',',
            keymaps = {
                ['.'] = 'textsubjects-smart',
                [';'] = 'textsubjects-container-outer',
                ['i;'] = 'textsubjects-container-inner',
            },
        })
    end
})

lazyload.event("VimEnter", "nvim-treesitter-textsubjects")
