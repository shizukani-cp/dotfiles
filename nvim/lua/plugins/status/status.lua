local function setup_highlights()
    local colors = require("tokyonight.colors").setup({
        style = "moon",
        on_colors = function() end,
        on_highlights = function() end,
    })

    local fg_ink = colors.bg_dark

    vim.api.nvim_set_hl(0, "StatusNormal", { fg = fg_ink, bg = colors.green, bold = true })
    vim.api.nvim_set_hl(0, "StatusInsert", { fg = fg_ink, bg = colors.blue, bold = true })
    vim.api.nvim_set_hl(0, "StatusVisual", { fg = fg_ink, bg = colors.magenta, bold = true })
    vim.api.nvim_set_hl(0, "StatusReplace", { fg = fg_ink, bg = colors.red, bold = true })
    vim.api.nvim_set_hl(0, "StatusCommand", { fg = fg_ink, bg = colors.yellow, bold = true })
    vim.api.nvim_set_hl(0, "StatusTerminal", { fg = fg_ink, bg = colors.green1, bold = true })
    vim.api.nvim_set_hl(0, "StatusMain", { fg = colors.fg, bg = colors.bg_statusline or colors.bg_dark })
end

local function skk_status()
    local ok, mode = pcall(vim.fn["skkeleton#mode"])
    if not ok then
        return ""
    end
    local map = { hira = "全ひ", kata = "全カ", hankata = "半ｶﾀ", zenkaku = "全Ａ", abbrev = "abbr" }
    return map[mode] or "英ab"
end

local function file()
    local fname = (function()
        local ft = vim.bo.filetype

        if ft == "oil" then
            local bufname = vim.api.nvim_buf_get_name(0)
            local path = bufname:gsub("^oil://", "")
            local rel_path = vim.fn.fnamemodify(path, ":~:.")
            if rel_path == "" then
                rel_path = "."
            end
            return "󰏇 " .. rel_path
        elseif ft == "toggleterm" then
            return " Terminal"
        elseif ft == "lazygit" then
            return " Lazygit"
        end

        return vim.fn.expand("%:.")
    end)()
    return fname .. "%m%r"
end

local function config()
    setup_highlights()
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
                std.filesize,
                std.encoding,
                std.filetype,
                "|",
                file,
                "[%l:%c]",
            },
        },
    })

    vim.opt.statusline = "%!v:lua.require('status.core').render()"
end

return function(manager)
    manager:add({
        id = "status.nvim",
        url = "https://github.com/shizukani-cp/status.nvim",
        dependencies = {
            "status-std",
            "status-git",
            "status-lsp",
            "tokyonight.nvim",
        },
        config = config,
        dev = false,
        dir = require("utils.local_plugin_path")("status.nvim"),
    })
    manager:load("status.nvim")
end
