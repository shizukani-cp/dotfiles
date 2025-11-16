local lazyload = require("manager.lazyload")

local function config()
    require('nvim-treesitter.configs').setup({
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                },
                selection_modes = {
                    ['@parameter.outer'] = 'v',
                    ['@function.outer'] = 'V',
                    ['@class.outer'] = '<c-v>',
                },
                include_surrounding_whitespace = true,
            },
            move = {
                enable = true,
                goto_next_start = {
                    ["Jb"] = "@block.outer",
                    ["Jc"] = "@class.outer",
                    ["Jf"] = "@function.outer",
                },
                goto_previous_start = {
                    ["Kb"] = "@block.outer",
                    ["Kc"] = "@class.outer",
                    ["Kf"] = "@function.outer",
                },
                set_jumps = true,
            }
        },
    })
    vim.keymap.set("n", "K", "<Nop>")
end

return function(manager)
    manager.add({
        id = "nvim-treesitter-textobjects",
        url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
        dependencies = {
            "nvim-treesitter",
        },
        config = config,
    })

    lazyload.event("VimEnter", "nvim-treesitter-textobjects")
end
