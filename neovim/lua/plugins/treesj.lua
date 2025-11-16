local lazyload = require("manager.lazyload")

local function config()
    require("treesj").setup()
    vim.keymap.del('n', '<leader>m')
    vim.keymap.del('n', '<leader>j')
end

return function(manager)
    manager.add({
        id = "treesj",
        url = "https://github.com/Wansmer/treesj",
        dependencies = {
            "nvim-treesitter"
        },
        config = config
    })
    lazyload.key("n", "<Leader>cS", "<Cmd>lua require('treesj').toggle()<Cr>", "treesj",
        { noremap = true, silent = true, desc = "Split or Join code block with autodetect" })
end
