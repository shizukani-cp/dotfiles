vim.scriptencoding = 'utf-8'
vim.o.encoding = 'utf-8'
vim.o.fileencoding = 'utf-8'
vim.o.fileencodings = "utf-8,cp932,euc-jp,sjis"
vim.g.mapleader = " "
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
vim.opt.relativenumber = true
vim.opt.messagesopt:append("wait:0")
vim.opt.messagesopt:remove("hit-enter")
