local function config()
    require("oil-git-signs").setup()
end

return function(manager)
    manager:add({
        id = "oil-git-signs.nvim",
        url = "https://github.com/FerretDetective/oil-git-signs.nvim",
        dependencies = {
            "oil.nvim",
        },
        config = config,
    })
    manager:locked_load("oil-git-signs.nvim")
end
