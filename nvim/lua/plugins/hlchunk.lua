local function config()
    require("hlchunk").setup({
        chunk = { enable = true },
        indent = { enable = true },
        blank = { enable = true },
    })
end

return function(manager)
    manager.add({
        id = "hlchunk.nvim",
        url = "https://github.com/shellRaining/hlchunk.nvim",
        config = config,
    })
    manager.load("hlchunk.nvim")
end
