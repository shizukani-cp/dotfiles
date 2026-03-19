local function config()
    require("treesitter-context").setup()
end

return function(manager)
    manager:add({
        id = "nvim-treesitter-context",
        url = "https://github.com/nvim-treesitter/nvim-treesitter-context",
        dependencies = {
            "nvim-treesitter",
        },
        config = config,
    })
    manager:locked_load("nvim-treesitter-context")
end
