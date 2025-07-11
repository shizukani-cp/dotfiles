return {
    "stevearc/oil.nvim",
    dependencies = {
        "echasnovski/mini.icons",
        {
            "FerretDetective/oil-git-signs.nvim",
            opts = {},
        },
    },
    opts = {
        win_options = {
            signcolumn = "yes:2",
            statuscolumn = "",
        },
    },
    keys = {
        {
            "<Space>f",
            "<CMD>Oil<CR>",
            mode = { "n", },
            silent = true,
        },
    },
}
