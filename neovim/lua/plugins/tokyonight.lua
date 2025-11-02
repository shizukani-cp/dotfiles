local function config()
    vim.cmd [[colorscheme tokyonight]]
end

return function(manager)
    manager.add({
        id = "tokyonight.nvim",
        url = "https://github.com/folke/tokyonight.nvim",
        config = config,
    })
    manager.load("tokyonight.nvim")
end
