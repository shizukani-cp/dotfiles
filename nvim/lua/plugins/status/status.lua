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

local git = {}

function git.branch()
    local branch = vim.b.gitsigns_head or vim.fn.FugitiveHead and vim.fn.FugitiveHead() or ""
    if branch == "" then
        return ""
    end
    return " " .. branch
end

function git.diff()
    local dict = vim.b.gitsigns_status_dict
    if not dict then
        return ""
    end

    local res = {}
    if (dict.added or 0) > 0 then
        table.insert(res, " " .. dict.added)
    end
    if (dict.changed or 0) > 0 then
        table.insert(res, " " .. dict.changed)
    end
    if (dict.removed or 0) > 0 then
        table.insert(res, " " .. dict.removed)
    end

    return #res > 0 and table.concat(res, " ") or ""
end

local lsp = {}
function lsp.status()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then
        return ""
    end

    local names = {}
    for _, client in ipairs(clients) do
        table.insert(names, client.name)
    end
    return " [" .. table.concat(names, ",") .. "]"
end

function lsp.diagnostics()
    local levels = {
        error = vim.diagnostic.severity.ERROR,
        warn = vim.diagnostic.severity.WARN,
        info = vim.diagnostic.severity.INFO,
        hint = vim.diagnostic.severity.HINT,
    }

    local res = {}
    local symbols = { error = " ", warn = " ", info = " ", hint = " " }

    for label, level in pairs(levels) do
        local count = #vim.diagnostic.get(0, { severity = level })
        if count > 0 then
            table.insert(res, symbols[label] .. count)
        end
    end

    return #res > 0 and table.concat(res, " ") or ""
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
    status.setup({
        components = {
            left = {
                std.mode,
                skk_status,
                "|",
                git.branch,
                git.diff,
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
        },
        config = config,
    })
    lock.load("status.nvim")
end
