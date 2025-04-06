return {
    "j-morano/buffer_manager.nvim",
    lazy = true,
    opts = {},
    keys = {
        {
            "<Space>b",
            "<CMD>lua require('buffer_manager.ui').toggle_quick_menu()<CR>",
            mode = { "n", },
            silent = true,
        },
    },
}
