local function config()
    vim.fn["skkeleton#azik#add_table"]("jis")
    local config_table = {
        kanaTable = "azik",
        lowercaseMap = {},
    }
    config_table.lowercaseMap["+"] = ";"
    vim.fn["skkeleton#config"](config_table)
    vim.fn["skkeleton#register_kanatable"]("rom", {
        ["+"] = { "っ", "^" },
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
        id = "skkeleton-azik-kanatable",
        url = "https://github.com/k16em/skkeleton-azik-kanatable",
        dependencies = {
            "skkeleton",
        },
        config = config,
    })
end
