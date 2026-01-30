local function config()
    require("tokyonight").setup({
        transparent = true,
        styles = {
            sidebars = "transparent",
            floats = "transparent",
        },
    })
    vim.cmd([[colorscheme tokyonight]])
end

return function(manager)
    manager.add({
        id = "tokyonight.nvim",
        url = "https://github.com/folke/tokyonight.nvim",
        config = config,
    })
    manager.load("tokyonight.nvim")
end
