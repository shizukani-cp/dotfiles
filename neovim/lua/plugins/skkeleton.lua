local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "skkeleton",
    url = "https://github.com/vim-skk/skkeleton",
    dependencies = {
        "denops.vim"
    },
    config = function()
        vim.fn["skkeleton#config"]({
            globalDictionaries = { '~/.config/eskk/SKK-JISYO.L' },
            eggLikeNewline = true,
            markerHenkan = "¦",
            markerHenkanSelect = "|",
        })
        vim.keymap.set({ "i", "c" }, "<C-s>", "<Plug>(skkeleton-toggle)",
            { noremap = true, silent = true, desc = "Toggle skkeleton enable/disable" })
    end
})
lazyload.event("InsertEnter", "skkeleton")
