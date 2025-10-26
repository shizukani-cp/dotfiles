local manager = require("utils.manager")

local installed_servers = require("plugins.lsp.data").installed_servers

manager.add({
    id = "mason-lspconfig.nvim",
    url = "https://github.com/mason-org/mason-lspconfig.nvim",
    config = function ()
         require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = installed_servers,
        })
    end
})
