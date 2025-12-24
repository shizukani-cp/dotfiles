local manager = require("manager.core")
manager.load("lazydev.nvim")
manager.load("nvim-lspconfig")
manager.load("mason.nvim")
manager.load("mason-lspconfig.nvim")
manager.load("ddc-source-lsp-setup")

local lsp_servers = require("plugins.lsp.data").lsp_servers
require("lazydev").setup()
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

local global_on_attach = on_attach

for name, cfg in pairs(lsp_servers) do
    local user_attach = cfg.on_attach
    cfg.on_attach = function(client, bufnr)
        if user_attach then user_attach(client, bufnr) end
        global_on_attach(client, bufnr)
    end
    vim.lsp.config(name, cfg)
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufnr = ev.buf
        if client.server_capabilities.completionProvider then
            vim.lsp.completion.enable(true, client.id, bufnr)
        end
    end,
})
