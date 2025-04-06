return {
    "folke/snacks.nvim",
    event = "VeryLazy",
    opts = {
        dashboard = { enabled = true },
        indent = { enabled = true },
        lazygit = { enabled = true },
    },
    keys = {
        {
            "<Space>g",
            function ()
                require("snacks").lazygit()
            end,
            mode = { "n", },
            silent = true,
            desc = "Show lazygit",
        }
    }
}
