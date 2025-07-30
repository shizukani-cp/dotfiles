local manager = require("utils.manager")
local lsp_servers = require("utils.lsp_data").lsp_servers

manager.add({
    id = "ddc-source-lsp",
    url = "https://github.com/Shougo/ddc-source-lsp",
    dependencies = {
        "mason.nvim",
        "mason-lspconfig.nvim",
        "nvim-lspconfig"
    },
    config = function ()
        local on_attach = function(client, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function()
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
        end

        vim.lsp.config('*', {
            capabilities = require("ddc_source_lsp").make_client_capabilities(),
        })

        local global_on_attach = on_attach
        local servers = {}

        for name, cfg in pairs(lsp_servers) do
            if type(cfg) == "table" then
                local user_attach = cfg.on_attach
                cfg.on_attach = function(client, bufnr)
                    if user_attach then user_attach(client, bufnr) end
                    global_on_attach(client, bufnr)
                end
                vim.lsp.config(name, cfg)
                table.insert(servers, name)
            end
        end

        vim.lsp.enable(servers)

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local bufnr = ev.buf
                if client.server_capabilities.completionProvider then
                    vim.lsp.completion.enable(true, client.id, bufnr)
                end
            end,
        })
    end
})
manager.load("ddc-source-lsp")
