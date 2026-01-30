local lazyload = require("manager.lazyload")

local function config()
    vim.fn["skkeleton#config"]({
        globalDictionaries = {
            "~/.local/share/skk/SKK-JISYO.L",
        },
        eggLikeNewline = true,
        markerHenkan = "¦",
        markerHenkanSelect = "|",
    })
    vim.keymap.set(
        { "i", "c" },
        "<Esc>",
        "<Plug>(skkeleton-toggle)",
        { noremap = true, silent = true, desc = "Skkeleton enable/disable" }
    )
end

return function(manager)
    manager.add({
        id = "skkeleton",
        url = "https://github.com/vim-skk/skkeleton",
        dependencies = {
            "denops.vim",
        },
        config = config,
    })
    lazyload.event("InsertEnter", "skkeleton")
    vim.keymap.set({ "i", "c" }, "<Esc>", "<Nop>")
end
