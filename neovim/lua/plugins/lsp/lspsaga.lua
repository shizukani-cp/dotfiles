return {
    "nvimdev/lspsaga.nvim",
    opts = {
        lightbulb = {
            enable = false,
        },
    },
    keys = {
        {
            "<Space>r",
            "<cmd>Lspsaga rename<cr>",
            mode = { "n" },
            silent = true,
            desc = "Symbol rename",
        },
    },
}
