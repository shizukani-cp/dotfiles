local function config()
    local installed_servers = require("plugins.lsp.data").installed_servers
    require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = installed_servers,
    })
end

return function(manager)
    manager.add({
        id = "mason-lspconfig.nvim",
        url = "https://github.com/mason-org/mason-lspconfig.nvim",
        config = config,
    })
end
