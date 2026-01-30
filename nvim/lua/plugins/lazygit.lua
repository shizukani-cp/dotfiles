local lazyload = require("manager.lazyload")

return function(manager)
    manager.add({
        id = "lazygit.nvim",
        url = "https://github.com/kdheepak/lazygit.nvim",
        dependencies = {
            "plenary.nvim",
        },
    })
    lazyload.key(
        "n",
        "<Leader>g",
        "<Cmd>LazyGit<Cr>",
        "lazygit.nvim",
        { noremap = true, silent = true, desc = "Lazygit" }
    )
end
