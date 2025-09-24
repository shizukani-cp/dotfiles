vim.scriptencoding = 'utf-8'
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.fileencodings = "utf-8,cp932,euc-jp,sjis"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.diagnostic.config({ virtual_text = true })

vim.g.clipboard = {
    name = 'win32yankClipboard',
    copy = {
        ['+'] = 'win32yank.exe -i --crlf',
        ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
        ['+'] = 'win32yank.exe -o --lf',
        ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 1,
}

vim.o.helplang = "ja,en"
vim.wo.cursorline = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.whichwrap = 'b,s,h,l,<,>'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 4

local term_grp = vim.api.nvim_create_augroup("NeovimTerminal", { clear = true })
vim.api.nvim_create_autocmd("TermOpen", {
    group = term_grp,
    pattern = "*",
    callback = function()
        vim.opt_local.number = false
        vim.cmd("startinsert")
    end,
})

local format_on_save_grp = vim.api.nvim_create_augroup("FormatOnSave", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = format_on_save_grp,
    pattern = "*",
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

local manager = require("utils.manager")

manager.lock()
require("plugins.2048")
require("plugins.Comment")
require("plugins.blamer")
require("plugins.bufferline")
require("plugins.ccc")
require("plugins.cmdline-hl")
require("plugins.dashboard")
require("plugins.ddc.ddc")
require("plugins.ddc.ddc-file")
require("plugins.ddc.ddc-filter-matcher_head")
require("plugins.ddc.ddc-filter-sorter_rank")
require("plugins.ddc.ddc-path")
require("plugins.ddc.ddc-source-buffer")
require("plugins.ddc.ddc-source-file")
require("plugins.ddc.ddc-source-lsp")
require("plugins.ddc.ddc-ui-native")
require("plugins.ddu.ddu")
require("plugins.ddu.ddu-filter-converter_devicon")
require("plugins.ddu.ddu-filter-matcher_substring")
require("plugins.ddu.ddu-kind-file")
require("plugins.ddu.ddu-source-buffer")
require("plugins.ddu.ddu-source-file_rec")
require("plugins.ddu.ddu-source-lsp")
require("plugins.ddu.ddu-ui-ff")
require("plugins.denippet")
require("plugins.deps.denops")
require("plugins.deps.nui")
require("plugins.deps.nvim-web-devicons")
require("plugins.deps.plenary")
require("plugins.dropbar")
require("plugins.fidget")
require("plugins.gemini")
require("plugins.gitsigns")
require("plugins.hlargs")
require("plugins.hlchunk")
require("plugins.hop")
require("plugins.lazygit")
require("plugins.lsp.lazydev")
require("plugins.lsp.mason")
require("plugins.lsp.mason-lspconfig")
require("plugins.lsp.nvim-lspconfig")
require("plugins.lsp.renamer")
require("plugins.lualine")
require("plugins.mkdir")
require("plugins.noice")
require("plugins.numb")
require("plugins.nvim-autopairs")
require("plugins.nvim-clorizer")
require("plugins.nvim-notify")
require("plugins.nvim-spectre")
require("plugins.nvim-syntax-info")
require("plugins.nvim-treesitter")
require("plugins.nvim-treesitter-context")
require("plugins.nvim_context_vt")
require("plugins.oil")
require("plugins.oil-git-signs")
require("plugins.reglist")
require("plugins.render-markdown")
require("plugins.satellite")
require("plugins.skkeleton")
require("plugins.smear-cursor")
require("plugins.tabset")
require("plugins.toggleterm")
require("plugins.tokyonight")
require("plugins.treesj")
require("plugins.undotree")
require("plugins.vim-translator")
require("plugins.vimdoc-ja")
require("plugins.which-key")
require("plugins.wtf")
manager.unlock()

vim.api.nvim_create_user_command("PluginList", function()
    local buf = vim.api.nvim_create_buf(false, true)
    local ids = {}

    for name, _ in pairs(manager.plugins or {}) do
        table.insert(ids, name)
    end

    if #ids == 0 then
        ids = { "No plugins found" }
    else
        table.sort(ids)
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, ids)
    vim.api.nvim_set_current_buf(buf)
end, {})

vim.api.nvim_set_keymap('v', '<Space>y', '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
vim.api.nvim_set_keymap('n', '<Space>p', '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.api.nvim_set_keymap('n', '<Space>P', '"+P', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.api.nvim_set_keymap('n', '<Space>z', 'za', { noremap = true, silent = true, desc = "Fold Under Cursor" })
vim.keymap.set({ 'n', 'x' }, 'gg', 'gg^', { noremap = true, silent = true, desc = "Go to the top of the file" })
vim.keymap.set({ 'n', 'x' }, 'G', 'G$', { noremap = true, silent = true, desc = "Go to the end of the file" })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
