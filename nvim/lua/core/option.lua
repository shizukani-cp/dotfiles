vim.diagnostic.config({ virtual_text = true })
vim.g.mapleader = " "

vim.opt.encoding = "utf-8"
vim.opt.expandtab = true
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = "utf-8,cp932,euc-jp,sjis"
vim.opt.foldcolumn = "1"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.helplang = "ja,en"
vim.opt.laststatus = 3
vim.opt.mouse = "n"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.termguicolors = true
vim.opt.updatetime = 1000
vim.opt.whichwrap = "b,s,h,l,<,>"

vim.scriptencoding = "utf-8"
vim.wo.cursorline = true
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

vim.g.hit_enter = true
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
    nargs = 0,
})

set_hit_enter()
