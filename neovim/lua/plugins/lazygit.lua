local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "lazygit.nvim",
    url = "https://github.com/kdheepak/lazygit.nvim",
    dependencies = {
        "plenary.nvim"
    },
})
lazyload.key("n", "<Leader>g", "<Cmd>LazyGit<Cr>", "lazygit.nvim",
    { noremap = true, silent = true, desc = "Lazygit" })
