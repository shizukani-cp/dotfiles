return {
    "stevearc/oil.nvim",
    dependencies = { "echasnovski/mini.icons" },
    config = function ()
        require("oil").setup({})
    end,
    keys = {
        {
            "<Space>f",
            "<CMD>Oil<CR>",
            mode = { "n", },
            silent = true,
        },
    },
}
