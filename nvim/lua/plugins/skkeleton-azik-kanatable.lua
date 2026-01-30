local function config()
    vim.fn["skkeleton#azik#add_table"]("jis")
    vim.fn["skkeleton#config"]({
        kanaTable = "azik",
    })
    vim.fn["skkeleton#register_keymap"]("input", "q", "katakana")
    vim.keymap.set(
        { "i", "c" },
        "<Esc>",
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
