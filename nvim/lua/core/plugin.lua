local managerpath = vim.fs.joinpath(vim.fn.stdpath("data"), "site", "pack", "manager", "start", "manager.nvim")
if not (vim.uv or vim.loop).fs_stat(managerpath) then
    local managerrepo = "https://github.com/shizukani-cp/manager.nvim.git"
    vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=main", managerrepo, managerpath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone manager.nvim:\n", "ErrorMsg" },
        }, true, {})
    end
end
local manager_dev = false
if not manager_dev then
    vim.opt.runtimepath:prepend(managerpath)
else
    vim.opt.runtimepath:prepend(require("utils.local_plugin_path")("manager.nvim"))
end

local manager = require("manager.core").new()

_G.manager = manager

local _ = manager.logger:on(function(e)
    if e.level >= 3 then
        vim.notify(e.msg, e.level)
    end
end)

local flags = {
    vime = vim.env.VIME,
}
local flags_all = false
for _, f in pairs(flags) do
    if f then
        flags_all = true
    end
end

local function plugin(mod, opt)
    if not flags_all then
        return require("plugins." .. mod)(manager)
    end
    if not opt then
        return
    end
    for fn, fv in pairs(flags) do
        if fv and opt[fn] then
            return require("plugins." .. mod)(manager)
        end
    end
    return
end

plugin("manager.manager-lock", { vime = true })
plugin("manager.manager-lazyload", { vime = true })

manager:lock()
plugin("Comment")
plugin("bufferline")
plugin("capture")
plugin("dashboard")
plugin("ddc.ddc")
plugin("ddc.ddc-source-lsp-setup")
plugin("ddu.ddu")
plugin("ddu.ddu-plugins")
plugin("ddu.ddu-source-manager")
plugin("denippet")
plugin("deps.denops", { vime = true })
plugin("deps.nui")
plugin("deps.nvim-web-devicons")
plugin("deps.plenary")
plugin("dial")
plugin("dropbar")
plugin("fidget")
plugin("friendly-snippets")
plugin("gitsigns", { vime = true })
plugin("hlargs")
plugin("hlchunk")
plugin("indent-blankline")
plugin("jumpcursor", { vime = true })
plugin("lazygit")
plugin("lsp.conform")
plugin("lsp.lazydev")
plugin("lsp.nvim-lspconfig")
plugin("lsp.renamer")
plugin("manager.manager-command")
plugin("manager.manager-remove")
plugin("manager.manager-ui")
plugin("manager.manager-update")
plugin("markview", { vime = true })
plugin("mkdir")
plugin("neoscroll", { vime = true })
plugin("noice")
plugin("numb")
plugin("nvim-autopairs", { vime = true })
plugin("nvim-surround")
plugin("nvim-various-textobjs")
plugin("nvim_context_vt")
plugin("nvimdoc-ja")
plugin("oklch-color-picker")
plugin("overseer")
plugin("satellite")
plugin("skkeleton", { vime = true })
plugin("smart-column")
plugin("smear-cursor", { vime = true })
plugin("sort")
plugin("status.status", { vime = true })
plugin("status.status-git", { vime = true })
plugin("status.status-lsp", { vime = true })
plugin("status.status-std", { vime = true })
plugin("tabset")
plugin("tiny-inline-diagnostic")
plugin("todo-comments")
plugin("toggleterm")
plugin("tokyonight", { vime = true })
plugin("treesitter.nvim-treesitter", { vime = true })
plugin("treesitter.nvim-treesitter-context")
plugin("treesitter.nvim-treesitter-textobjects")
plugin("treesitter.nvim-ts-autotag", { vime = true })
plugin("trouble")
plugin("undotree", { vime = true })
plugin("vim-better-whitespace")
plugin("vim-illuminate")
plugin("vim-tmux-navigator")
plugin("vimdoc-ja")
plugin("vist.vist")
plugin("vist.vist-file")
plugin("visual-whitespace")
plugin("which-key", { vime = true })
manager:unlock()
plugin("lsp.config")
