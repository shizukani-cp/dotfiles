local manager = require("utils.manager")

manager.add({
    id = "snacks.nvim",
    url = "https://github.com/folke/snacks.nvim",
    config = function ()
        require("snacks").setup({
            dashboard = { enabled = false },
            input = { enabled = true },
            lazygit = { enabled = true },
            picker = { enabled = true },
        })
        vim.api.nvim_set_keymap("n", "<Space>g", "<Cmd>lua require('snacks').lazygit()<CR>", { noremap = true, silent = true, desc = "Show lazygit" })
        vim.api.nvim_set_keymap("n", "<Space>F", "<Cmd>lua require('snacks').picker.files()<CR>", { noremap = true, silent = true, desc = "Open file picker" })
        vim.api.nvim_set_keymap("n", "<Space>b", "<Cmd>lua require('snacks').picker.buffers()<CR>", { noremap = true, silent = true, desc = "Open buffer picker" })
        vim.api.nvim_set_keymap("n", "<Space>s", "<Cmd>lua require('snacks').picker.symbols()<CR>", { noremap = true, silent = true, desc = "Open symbol picker" })
    end
})
manager.load("snacks.nvim")

