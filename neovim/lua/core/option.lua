vim.scriptencoding = 'utf-8'
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.fileencodings = "utf-8,cp932,euc-jp,sjis"
vim.g.mapleader = " "
vim.diagnostic.config({ virtual_text = true })

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
vim.opt.relativenumber = true

vim.g.hit_enter = false
local function set_hit_enter()
    if vim.g.hit_enter then
        vim.opt.messagesopt:append("hit-enter")
        vim.opt.messagesopt:remove("wait:0")
    else
        vim.opt.messagesopt:append("wait:0")
        vim.opt.messagesopt:remove("hit-enter")
    end
    vim.g.hit_enter = not vim.g.hit_enter
end

vim.api.nvim_create_user_command("ToggleHitEnter", set_hit_enter, {
    nargs = 0
})

set_hit_enter()
