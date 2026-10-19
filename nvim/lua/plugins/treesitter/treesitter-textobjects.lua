local function config()
    require("nvim-treesitter-textobjects").setup({
        select = {
            enable = true,
            lookahead = true,
            selection_modes = {
                ["@class.outer"] = "V",
                ["@function.outer"] = "V",
            },
        },
        move = {
            set_jumps = true,
        },
    })
end

return function(manager)
    vim.g.no_plugin_maps = true

    manager:add({
        id = "nvim-treesitter-textobjects",
        url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = { "nvim-treesitter" },
        config = config,
    })
    manager:lazyload_event("SafeState", "nvim-treesitter-textobjects")
    manager:lazyload_key({ "x", "o" }, "af", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
    end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "outer function" })
    manager:lazyload_key({ "x", "o" }, "if", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
    end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "inner function" })
    manager:lazyload_key({ "x", "o" }, "ac", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
    end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "outer class" })
    manager:lazyload_key({ "x", "o" }, "ic", function()
        require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
    end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "inner class" })
    manager:lazyload_key({ "n", "x", "o" }, "]f", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "next function" })
    manager:lazyload_key({ "n", "x", "o" }, "]c", function()
        require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
    end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "next class" })
    manager:lazyload_key({ "n", "x", "o" }, "[f", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
    end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "previous function" })
    manager:lazyload_key({ "n", "x", "o" }, "[c", function()
        require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
    end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "previous class" })
end
