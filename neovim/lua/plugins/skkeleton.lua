local lazyload = require("utils.lazyload")

local function config()
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

return function(manager)
    manager.add({
        id = "skkeleton",
        url = "https://github.com/vim-skk/skkeleton",
        dependencies = {
            "denops.vim"
        },
        config = config
    })
    lazyload.event("InsertEnter", "skkeleton")
end
