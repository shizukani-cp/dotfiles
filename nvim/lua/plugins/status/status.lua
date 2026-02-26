local lock = require("manager.lock")

local function setup_highlights()
    local colors = {
        blue = "#82aaff",
        green = "#c3e88d",
        purple = "#c792ea",
        red = "#ff5370",
        bg = "#2c323c",
        fg = "#abb2bf",
    }

    vim.api.nvim_set_hl(0, "StatusNormal", { fg = colors.bg, bg = colors.green, bold = true })
    vim.api.nvim_set_hl(0, "StatusInsert", { fg = colors.bg, bg = colors.blue, bold = true })
    vim.api.nvim_set_hl(0, "StatusVisual", { fg = colors.bg, bg = colors.purple, bold = true })
    vim.api.nvim_set_hl(0, "StatusReplace", { fg = colors.bg, bg = colors.red, bold = true })
    vim.api.nvim_set_hl(0, "StatusMain", { fg = colors.fg, bg = colors.bg })
end

local function skk_status()
    local ok, mode = pcall(vim.fn["skkeleton#mode"])
    if not ok then
        return ""
    end
    local map = { hira = "全ひ", kata = "全カ", hankata = "半ｶﾀ", zenkaku = "全Ａ", abbrev = "abbr" }
    return map[mode] or "英ab"
end

setup_highlights()
local function config()
    local status = require("status.core")
    local std = require("status.std")
    local git = require("status.git")
    local lsp = require("status.lsp")
    status.setup({
        components = {
            left = {
                std.mode,
                skk_status,
                "|",
                git.branch,
                git.diff,
                "|",
                lsp.status,
                lsp.diagnostics,
            },
            right = {
                function()
                    return "こと=こ,ます=む,です=づ,たら=た,から=け,られ=ら"
                end,
                "|",
                std.filesize,
                std.encoding,
                std.filetype,
                "|",
                std.file,
                "[%l:%c]",
            },
        },
    })

    vim.opt.statusline = "%!v:lua.require('status.core').render()"
end

return function(manager)
    manager.add({
        id = "status.nvim",
        url = "https://github.com/shizukani-cp/status.nvim",
        dependencies = {
            "status-std",
            "status-git",
            "status-lsp",
        },
        config = config,
        dev = false,
        dir = require("utils.local_plugin_path")("status.nvim"),
    })
    lock.load("status.nvim")
end
