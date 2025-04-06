return {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    event = "InsertEnter",
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_installation = true,
            ensure_installed = { "lua_ls", "pylsp", "rust_analyzer", "html", "cssls", "ts_ls" },
        })

        local lspconfig = require("lspconfig")
        local on_attach = function(_, bufnr)
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })
        end

        lspconfig.lua_ls.setup{
            on_attach = on_attach,
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = {'vim'},
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                },
            },
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }

        lspconfig.pylsp.setup{
            on_attach = on_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
            cmd = { "pylsp" },
            settings = {
                pylsp = {
                    plugins = {
                        pyflakes = { enabled = true },
                        pylint = { enabled = true },
                    }
                }
            }
        }

        lspconfig.rust_analyzer.setup{
            on_attach = on_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }

        lspconfig.html.setup{
            on_attach = on_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }
        lspconfig.cssls.setup{
            on_attach = on_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }
        lspconfig.ts_ls.setup{
            on_attach = on_attach,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }
    end,
}
