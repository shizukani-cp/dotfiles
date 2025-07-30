local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

manager.add({
    id = "lazygit.nvim",
    url = "https://github.com/kdheepak/lazygit.nvim",
    dependencies = {
        "plenary.nvim"
    },
})
set_keymap("n", "<Space>g", "<Cmd>LazyGit<Cr>", "lazygit.nvim", { noremap = true, silent = true, desc = "Show lazygit" })
