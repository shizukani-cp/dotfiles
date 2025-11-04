vim.api.nvim_set_keymap('x', '<Leader>y', '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
vim.api.nvim_set_keymap('n', '<Leader>p', '"+p', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.api.nvim_set_keymap('n', '<Leader>P', '"+P', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.keymap.set('n', '<Leader>cu', function() require("utils.uuid").yank_uuid() end,
    { noremap = true, silent = true, desc = "Yank UUID" })
vim.keymap.set("n", "<Leader>en", function()
    if vim.wo.relativenumber then
        vim.wo.relativenumber = false
        vim.wo.number = true
    else
        vim.wo.relativenumber = true
        vim.wo.number = true
    end
end, { desc = "Relative/Absolute Line Numbers" })
vim.keymap.set({ 'n', 'x' }, 'gg', 'gg^', { noremap = true, silent = true, desc = "Go to the top of the file" })
vim.keymap.set({ 'n', 'x' }, 'G', 'G$', { noremap = true, silent = true, desc = "Go to the end of the file" })
vim.keymap.set('n', 'o', 'o<Esc>', { noremap = true, silent = true, desc = "Add new line" })
vim.keymap.set('n', 'O', 'O<Esc>', { noremap = true, silent = true, desc = "Add new line before" })
vim.keymap.set('n', 'L', ':bnext<CR>', { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set('n', 'H', ':bprevious<CR>', { noremap = true, silent = true, desc = "Previous buffer" })
vim.keymap.set('n', '<Cr>', 'za', { noremap = true, silent = true, desc = "Fold under Cursor" })
vim.keymap.set('i', 'fj', '<Esc><Cmd>w<Cr>', { noremap = true })
vim.keymap.set('i', 'fk', '<Esc>', { noremap = true })
vim.keymap.set('i', 'fh', '<Esc><Cmd>wq<Cr>', { noremap = true })
vim.keymap.set('i', '<Esc>', vim.schedule_wrap(function()
    vim.notify("Escは無効にしておいたぞ。代わりに 'fj' を使っとけ(^^)", vim.log.levels.WARN)
    return ""
end), { noremap = true, expr = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
