-- vim.api.nvim_set_keymap("x", "<Leader>y", '"+y', { noremap = true, silent = true, desc = "Yank to clipboard" })
-- vim.api.nvim_set_keymap("n", "<Leader>P", '"+P', { noremap = true, silent = true, desc = "Paste from clipboard" })
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
vim.keymap.set({ "n" }, "<Leader>ef", function()
    if vim.g.formatonsave then
        vim.g.formatonsave = false
    else
        vim.g.formatonsave = true
    end
end, { noremap = true, silent = true, desc = "Toggle fonmat on save" })
manager:lazyload_key(
    "n",
    "s",
    "<Cmd>HopWord<Cr>",
    "hop.vim",
    { noremap = true, silent = true, desc = "Go to any word in the current buffer." }
)
manager:lazyload_key(
    "n",
    "<Leader>g",
    "<Cmd>LazyGit<Cr>",
    "lazygit.nvim",
    { noremap = true, silent = true, desc = "Lazygit" }
)
manager:lazyload_key({ "x", "o" }, "af", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "outer function" })
manager:lazyload_key({ "x", "o" }, "if", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "inner function" })
manager:lazyload_key({ "x", "o" }, "ac", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "outer class" })
manager:lazyload_key({ "x", "o" }, "ic", function()
    require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "inner class" })
manager:lazyload_key({ "n", "x", "o" }, "]f", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "next function" })
manager:lazyload_key({ "n", "x", "o" }, "]c", function()
    require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "next class" })
manager:lazyload_key({ "n", "x", "o" }, "[f", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "previous function" })
manager:lazyload_key({ "n", "x", "o" }, "[c", function()
    require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
end, "nvim-treesitter-textobjects", { noremap = true, silent = true, desc = "previous class" })
manager:lazyload_key(
    "n",
    "<Leader>cd",
    "<Cmd>Trouble diagnostics toggle<Cr>",
    "trouble.nvim",
    { noremap = true, silent = true, desc = "Diagnostics" }
)
-- vim.keymap.set("n", "<Leader>eo", "<Cmd>noh<Cr>", { desc = ":noh" })
-- vim.keymap.set("n", "<Leader>em", "<Cmd>messages<Cr>", { desc = "Messages" })
-- vim.keymap.set({ "n", "x" }, "gg", "gg^", { noremap = true, silent = true, desc = "Go to the top of the file" })
-- vim.keymap.set({ "n", "x" }, "G", "G$", { noremap = true, silent = true, desc = "Go to the end of the file" })
-- vim.keymap.set("n", "L", ":bnext<CR>", { noremap = true, silent = true, desc = "Next buffer" })
-- vim.keymap.set("n", "H", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous buffer" })

-- vim.api.nvim_set_keymap("i", "<F27>", "<Esc><Cmd>w<Cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<F27>", "<Esc><Cmd>xa!<Cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("t", "<F27>", "<C-\\><C-n>", { noremap = true, silent = true })
--
-- vim.api.nvim_set_keymap("i", "<C-F3>", "<Esc><Cmd>w<Cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C-F3>", "<Esc><Cmd>xa!<Cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("t", "<C-F3>", "<C-\\><C-n>", { noremap = true, silent = true })
