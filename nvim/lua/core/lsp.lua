local manager = require("manager.core")
manager.load("lazydev.nvim")
manager.load("nvim-lspconfig")
manager.load("mason.nvim")
manager.load("mason-lspconfig.nvim")
manager.load("ddc-source-lsp-setup")
manager.load("conform.nvim")

local lsp_servers = require("data.lsp").lsp_servers
require("lazydev").setup()
local on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
        require("conform").format({ bufnr = bufnr, lsp_fallback = true })
    end, { desc = 'Format current buffer with conform.nvim' })
end

local global_on_attach = on_attach

for name, cfg in pairs(lsp_servers) do
    local user_attach = cfg.on_attach
    cfg.on_attach = function(client, bufnr)
        if name == "lua_ls" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end
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

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("LspStartNodeOrDeno", { clear = true }),
    callback = function(ctx)
        if not vim.tbl_contains(
                { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
                ctx.match
            ) then
            return
        end

        if vim.fn.findfile("package.json", ".;") ~= "" then
            vim.lsp.start("vtsls")
            return
        end

        vim.lsp.start("denols")
    end,
})
