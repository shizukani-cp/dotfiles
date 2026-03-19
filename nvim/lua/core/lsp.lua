_G.manager:locked_load("lazydev.nvim")
_G.manager:locked_load("nvim-lspconfig")
_G.manager:locked_load("ddc-source-lsp-setup")
_G.manager:locked_load("conform.nvim")

local lsp_servers = require("data.lsp").lsp_servers
require("lazydev").setup()
local on_attach = function(_, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
        require("conform").format({ bufnr = bufnr, lsp_fallback = true })
    end, { desc = "Format current buffer with conform.nvim" })
end

local global_on_attach = on_attach

for name, cfg in pairs(lsp_servers) do
    local user_attach = cfg.on_attach
    cfg.on_attach = function(client, bufnr)
        if name == "lua_ls" then
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end
        if user_attach then
            user_attach(client, bufnr)
        end
        global_on_attach(client, bufnr)
    end
    vim.lsp.config(name, cfg)
    vim.lsp.enable(name)
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local bufnr = ev.buf
        if not client then
            return
        end
        if client.server_capabilities.completionProvider then
            vim.lsp.completion.enable(true, client.id, bufnr)
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("LspStartNodeOrDeno", { clear = true }),
    callback = function(ctx)
        if
            not vim.tbl_contains({
                "javascript",
                "javascriptreact",
                "javascript.jsx",
                "typescript",
                "typescriptreact",
                "typescript.tsx",
            }, ctx.match)
        then
            return
        end

        if vim.fn.findfile("package.json", ".;") ~= "" then
            local config = vim.lsp.config["ts_ls"]
            if config then
                vim.lsp.start(config)
            end
            return
        end

        local deno_config = vim.lsp.config["denols"]
        if deno_config then
            vim.lsp.start(deno_config)
        end
    end,
})
