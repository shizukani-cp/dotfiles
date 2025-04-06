return {
    'stevearc/aerial.nvim',
    opts = {},
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    keys = {
        {
            "<Space>s",
            "<CMD>AerialToggle float<CR>",
            mode = { "n", },
            silent = true,
        },
    },
}
