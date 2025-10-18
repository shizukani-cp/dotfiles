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
            globalDictionaries = {
                '~/.config/eskk/SKK-JISYO.L',
                '~/.config/eskk/SKK-JISYO.assoc',
                '~/.config/eskk/SKK-JISYO.fullname',
                '~/.config/eskk/SKK-JISYO.geo',
                '~/.config/eskk/SKK-JISYO.jinmei',
                '~/.config/eskk/SKK-JISYO.propernoun',
                '~/.config/eskk/SKK-JISYO.station',
            },
            eggLikeNewline = true,
            markerHenkan = "¦",
            markerHenkanSelect = "|",
        })
        vim.keymap.set({ "i", "c" }, "<C-s>", "<Plug>(skkeleton-toggle)",
            { noremap = true, silent = true, desc = "Skkeleton enable/disable" })
    end
})
lazyload.event("InsertEnter", "skkeleton")
