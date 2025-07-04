return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/nvim-cmp",
        "saghen/blink.cmp",
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "onsails/lspkind-nvim",
        "uga-rosa/cmp-skkeleton",
    },
    config = function()
        local lsp_servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        diagnostics = { globals = {'vim'} },
                        workspace = {
                            library = vim.list_extend(vim.api.nvim_get_runtime_file("lua", true), {
                                "${3rd}/luv/library",
                                "${3rd}/busted/library",
                                "${3rd}/luassert/library",
                            }),
                            checkThirdParty = "Disable",
                        },
                    },
                },
            },
            pylsp = {
                cmd = { "pylsp" },
                settings = {
                    pylsp = {
                        plugins = {
                            pyflakes = { enabled = true },
                            pylint = { enabled = true },
                        },
                    },
                },
            },
            rust_analyzer = {},
            html = {},
            cssls = {},
            ts_ls = {},
        }

        local installed_servers = vim.tbl_keys(lsp_servers)

        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = installed_servers,
        })

        local lspconfig = require("lspconfig")
        local cmp = require("cmp")
        local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        local on_attach = function(client, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
        end

        vim.lsp.config('*', {
            on_attach = on_attach,
            capabilities = cmp_capabilities,
        })

        for server_name, server_config in pairs(lsp_servers) do
            if type(server_config) == 'table' then
                vim.lsp.config(server_name, server_config)
            end
            vim.lsp.enable(server_name)
        end

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(ev)
                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                local bufnr = ev.buf
                if client.server_capabilities.completionProvider then
                    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
                end
            end,
        })

    cmp.setup({
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            ['<Tab>'] = cmp.mapping.select_next_item(),
            ['<S-Tab>'] = cmp.mapping.select_prev_item(),
            ['<C-k>'] = cmp.mapping.select_prev_item(),
            ['<C-j>'] = cmp.mapping.select_next_item(),
            ['<C-e>'] = cmp.mapping.close(),
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
            { name = "skkeleton" },
        },
        formatting = {
            fields = { "menu", "abbr", "kind" },
            format = function(entry, vim_item)
                local menu_icon = {
                    nvim_lsp = "lsp",
                    luasnip = "snip",
                    buffer = "buf",
                    path = "path",
                    skkeleton = "skk",
                }
                vim_item.menu = menu_icon[entry.source.name] or "?"
                return vim_item
            end,
        },
        experimental = {
            ghost_text = {
                hl_group = "LspCodeLens",
            },
        },
    })
end,
}

