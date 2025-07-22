return {
    'Wansmer/treesj',
    keys = {
        {
            "<space>t",
            function()
                require("treesj").toggle()
            end,
            mode = { "n", },
            silent = true,
            desc = "Split / Join",
        },
    },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
}
