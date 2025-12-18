local function config()
    local lsp_servers = require("plugins.lsp.data").lsp_servers
    require("lazydev").setup()
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
            require("lspconfig")[name].setup(cfg)
        end
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
end

return function(manager)
    manager.add({
        id = "nvim-lspconfig",
        url = "https://github.com/neovim/nvim-lspconfig",
        dependencies = {
            "lazydev.nvim",
            "mason.nvim",
            "mason-lspconfig.nvim",
            "ddc-source-lsp",
        },
        config = config,
    })
    manager.load("nvim-lspconfig")
end
