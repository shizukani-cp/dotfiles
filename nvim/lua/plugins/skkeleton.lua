local lazyload = require("manager.lazyload")
local huj8_table = require("data.huj8_auto")

local function config()
    vim.fn["skkeleton#register_kanatable"]("huj8", huj8_table, 1)
    local lowercases = {}
    lowercases['"'] = "2"
    lowercases["#"] = "3"
    lowercases["$"] = "4"
    lowercases["%"] = "5"
    lowercases["&"] = "6"
    lowercases["'"] = "7"
    lowercases["("] = "8"
    lowercases[")"] = "9"
    lowercases["+"] = ";"
    vim.fn["skkeleton#config"]({
        globalDictionaries = {
            "~/.local/share/skk/SKK-JISYO.L",
        },
        eggLikeNewline = true,
        markerHenkan = "¦",
        markerHenkanSelect = "|",
        kanaTable = "huj8",
        lowercaseMap = lowercases,
    })
    vim.keymap.set(
        { "i", "c" },
        "<F9>",
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
