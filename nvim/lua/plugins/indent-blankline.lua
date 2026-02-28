local function config()
    require("ibl").setup()
end

return function(manager)
    manager:add({
        id = "indent-blankline.nvim",
        url = "https://github.com/lukas-reineke/indent-blankline.nvim",
        config = config,
    })

    manager:lazyload_event("BufRead", "indent-blankline.nvim")
end
