local M = {}

M.lsp_servers = {
    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = { globals = { 'vim' } },
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
    ts_ls = {
        root_dir = function(fname)
            if fname and string.find(fname, "/denops/") then
                return nil
            end
            local util = require("lspconfig.util")
            return util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
        end,
    },
    denols = {
        init_options = {
            lint = true,
            unstable = true,
        },
        root_dir = function(fname)
            if fname and string.find(fname, "/denops/") then
                local util = require("lspconfig.util")
                return util.root_pattern(".git", "deno.json", "deno.jsonc")(fname)
            end
            return nil
        end,
    },
    jsonls = {},
}

M.installed_servers = vim.tbl_keys(M.lsp_servers)

return M
