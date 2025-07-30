local M = {}

M.lsp_servers = {
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
    jsonls = {},
}

M.installed_servers = vim.tbl_keys(M.lsp_servers)

return M
