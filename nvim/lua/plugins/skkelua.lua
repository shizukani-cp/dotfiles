local function config()
    local huj8_table = require("data.huj8")
    require("skkelua").register_kanatable("huj8", huj8_table, 1)
    require("skkelua").config({
        globalDictionaries = {
            "~/.local/share/skk/SKK-JISYO.L",
        },
        eggLikeNewline = true,
        markerHenkan = "¦",
        markerHenkanSelect = "|",
        kanaTable = "huj8",
    })
    local is_vime = (vim.env.VIME ~= nil)
    if is_vime then
        require("skkelua").initialize()
    end
    vim.keymap.set(
        { "i", "c" },
        "<C-F1>",
        "<Plug>(skkelua-enable)",
        { noremap = true, silent = true, desc = "Skkelua enable" }
    )
    vim.keymap.set(
        { "i", "c" },
        "<C-F2>",
        "<Plug>(skkelua-disable)",
        { noremap = true, silent = true, desc = "Skkelua disable" }
    )
    vim.keymap.set(
        { "i", "c" },
        "<F25>",
        "<Plug>(skkelua-enable)",
        { noremap = true, silent = true, desc = "Skkelua enable" }
    )
    vim.keymap.set(
        { "i", "c" },
        "<F26>",
        "<Plug>(skkelua-disable)",
        { noremap = true, silent = true, desc = "Skkelua disable" }
    )
end

return function(manager)
    manager:add({
        id = "skkelua",
        url = "https://github.com/kjuq/skkelua.nvim",
        config = config,
    })
    manager:lazyload_event("InsertEnter", "skkelua")
end
