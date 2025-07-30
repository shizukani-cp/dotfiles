local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

manager.add({
    id = "telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim",
    dependencies = {
        "plenary.nvim",
        "nvim-treesitter",
        "nvim-web-devicons",
    },
    config = function ()
        require("telescope").setup()
    end
})

set_keymap("n", "<Space>F", "<Cmd>lua require('telescope.builtin').find_files()<Cr>", "telescope.nvim", { noremap = true, silent = true, desc = "Open file picker" })
set_keymap("n", "<Space>b", "<Cmd>lua require('telescope.builtin').buffers()<Cr>", "telescope.nvim", { noremap = true, silent = true, desc = "Open buffer picker" })
set_keymap("n", "<Space>s", "<Cmd>lua require('telescope.builtin').lsp_workspace_symbols()<Cr>", "telescope.nvim", { noremap = true, silent = true, desc = "Open symbol picker" })

