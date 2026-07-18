vim.api.nvim_set_keymap("x", "<Leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
vim.api.nvim_set_keymap("n", "<Leader>P", '"+P', { noremap = true, silent = true, desc = "Paste from clipboard" })
vim.keymap.set("n", "<Leader>cu", function()
    require("utils.uuid").yank_uuid()
end, { noremap = true, silent = true, desc = "Yank UUID" })
vim.keymap.set("n", "<Leader>en", function()
    if vim.wo.relativenumber then
        vim.wo.relativenumber = false
        vim.wo.number = true
    else
        vim.wo.relativenumber = true
        vim.wo.number = true
    end
end, { desc = "Relative/Absolute Line Numbers" })
vim.keymap.set("n", "<Leader>eh", "<Cmd>ToggleHitEnter<Cr>", { desc = "Enable/Disable hit enter" })
vim.keymap.set("n", "<Leader>eo", "<Cmd>noh<Cr>", { desc = ":noh" })
vim.keymap.set("n", "<Leader>em", "<Cmd>messages<Cr>", { desc = "Messages" })
vim.keymap.set({ "n", "x" }, "gg", "gg^", { noremap = true, silent = true, desc = "Go to the top of the file" })
vim.keymap.set({ "n", "x" }, "G", "G$", { noremap = true, silent = true, desc = "Go to the end of the file" })
vim.keymap.set("n", "L", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
vim.keymap.set("n", "H", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

vim.api.nvim_set_keymap("i", "<F27><F27>", "<Esc><Cmd>w<Cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<F27>r", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<F27>s", "<Esc><Cmd>xa!<Cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<F27><F27>", "<C-\\><C-n>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("i", "<C-F3><C-F3>", "<Esc><Cmd>w<Cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-F3>r", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-F3>s", "<Esc><Cmd>xa!<Cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-F3><C-F3>", "<C-\\><C-n>", { noremap = true, silent = true })
