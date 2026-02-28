local function config()
    require("gitsigns").setup()
end

return function(manager)
    manager:add({
        id = "gitsigns.nvim",
        url = "https://github.com/lewis6991/gitsigns.nvim",
        config = config,
    })
    manager:lazyload_event("BufReadPost", "gitsigns.nvim")
end
