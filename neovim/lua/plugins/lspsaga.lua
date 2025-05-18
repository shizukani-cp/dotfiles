return {
    "nvimdev/lspsaga.nvim",
    opts = {},
    lazy = false,
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
