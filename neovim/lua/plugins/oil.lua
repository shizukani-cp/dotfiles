local manager = require("utils.manager")

manager.add({
    id = "oil.nvim",
    url = "https://github.com/stevearc/oil.nvim",
    dependencies = {
        "nvim-web-devicons",
    },
    config = function()
        require("oil").setup({
            win_options = {
                signcolumn = "yes:2",
                statuscolumn = "",
            },
            view_options = {
                show_hidden = true,
            },
        })
        vim.keymap.set("n", "<Leader>f", "<Cmd>Oil<Cr>", { noremap = true, silent = true, desc = "Open oil buffer" })
    end
})
