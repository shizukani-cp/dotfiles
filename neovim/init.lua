vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.g.mapleader = " "
vim.opt.number = true
vim.opt.whichwrap = 'b,s,h,l,<,>'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 4
vim.opt.clipboard:append('unnamedplus,unnamed')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },
    defaults = {
        lazy = false,
    },
})

vim.api.nvim_set_keymap('v', '<Space>y', 'y', { noremap = true, silent = true, desc = "Yank to clipboard" })
vim.api.nvim_set_keymap('n', '<Space>p', 'p', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.api.nvim_set_keymap('n', '<Space>P', 'P', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

