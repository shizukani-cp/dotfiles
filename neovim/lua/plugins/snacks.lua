return {
    "folke/snacks.nvim",
    event = "VeryLazy",
    opts = {
        dashboard = { enabled = true },
        input = { enabled = true },
        lazygit = { enabled = true },
        picker = { enabled = true },
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
        },
        {
            "<Space>F",
            function ()
                require('snacks').picker.files()
            end,
            mode = { "n", },
            silent = true,
            desc = "Open file picker",
        },
        {
            "<Space>b",
            function ()
                require('snacks').picker.buffers()
            end,
            mode = { "n", },
            silent = true,
            desc = "Open buffer picker",
        },
        {
            "<Space>s",
            function ()
                require('snacks').picker.lsp_symbols()
            end,
            mode = { "n", },
            silent = true,
            desc = "Open symbol picker"
        },

    },
}
