local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "treesj",
    url = "https://github.com/Wansmer/treesj",
    dependencies = {
        "nvim-treesitter"
    },
    config = function()
        require("treesj").setup()
        vim.keymap.del('n', '<leader>m')
        vim.keymap.del('n', '<leader>j')
    end
})
lazyload.key("n", "<Leader>S", "<Cmd>lua require('treesj').toggle()<Cr>", "treesj",
    { noremap = true, silent = true, desc = "Split or Join code block with autodetect" })
