return function(manager)
    manager.add({
        id = "nvim-treesitter",
        url = "https://github.com/nvim-treesitter/nvim-treesitter",
    })
    manager.load("nvim-treesitter")
end
