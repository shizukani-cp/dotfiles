return {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
    opts = {
        filesystem = {
            filtered_items = {
                visible = true,
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },
        window = {
            position = "float",
            width = 40,
            height = 30,
        },
    },
    keys = {
        {
            "<Space>f",
            "<CMD>Neotree<CR>",
            mode = { "n", },
            silent = true,
        },
    },
}
