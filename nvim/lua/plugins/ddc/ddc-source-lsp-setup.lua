local function config()
    require("ddc_source_lsp_setup").setup({
        override_capabilities = true,
        respect_trigger = true,
    })
end

return function(manager)
    manager:add({
        id = "ddc-source-lsp-setup",
        url = "https://github.com/uga-rosa/ddc-source-lsp-setup",
        dependencies = {
            "ddc.vim",
            "ddc-source-lsp",
        },
        config = config,
    })
end
