local function config()
    local huj8_table = require("data.huj8")
    vim.fn["skkeleton#register_kanatable"]("huj8", huj8_table, 1)
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
        "<C-F1>",
        "<Plug>(skkeleton-enable)",
        { noremap = true, silent = true, desc = "Skkeleton enable" }
    )
    vim.keymap.set(
        { "i", "c" },
        "<C-F2>",
        "<Plug>(skkeleton-disable)",
        { noremap = true, silent = true, desc = "Skkeleton disable" }
    )
    vim.keymap.set(
        { "i", "c" },
        "<F25>",
        "<Plug>(skkeleton-enable)",
        { noremap = true, silent = true, desc = "Skkeleton enable" }
    )
    vim.keymap.set(
        { "i", "c" },
        "<F26>",
        "<Plug>(skkeleton-disable)",
        { noremap = true, silent = true, desc = "Skkeleton disable" }
    )
end

return function(manager)
    manager:add({
        id = "skkeleton",
        url = "https://github.com/vim-skk/skkeleton",
        dependencies = {
            "denops.vim",
        },
        config = config,
    })
    manager:lazyload_event("InsertEnter", "skkeleton")
end
