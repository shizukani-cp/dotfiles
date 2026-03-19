local function config()
    require("tokyonight").setup({
        transparent = true,
        styles = {
            sidebars = "transparent",
            floats = "transparent",
        },
        on_colors = function() end,
        on_highlights = function() end,
    })
    vim.cmd([[colorscheme tokyonight]])
end

return function(manager)
    manager:add({
        id = "tokyonight.nvim",
        url = "https://github.com/folke/tokyonight.nvim",
        config = config,
    })
    manager:locked_load("tokyonight.nvim")
end
