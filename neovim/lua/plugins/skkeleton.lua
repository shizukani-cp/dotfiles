local manager = require("utils.manager")

manager.add({
    id = "skkeleton",
    url = "https://github.com/vim-skk/skkeleton",
    dependencies = {
        "denops.vim"
    },
    config = function ()
        vim.fn["skkeleton#config"]({
            globalDictionaries = { '~/.config/eskk/SKK-JISYO.L' },
            eggLikeNewline = true,
        })
        vim.keymap.set({"i", "c"}, "<C-s>", "<Plug>(skkeleton-toggle)", { noremap = true, silent = true, desc = "Toggle skkeleton enable/disable" })
    end
})
vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("skkeleton_load", { clear = true }),
    pattern = "*",
    callback = function()
        manager.load("skkeleton")
    end,
})

