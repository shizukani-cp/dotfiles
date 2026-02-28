local function config()
    require("bufferline").setup()
end

return function(manager)
    manager:add({
        id = "bufferline.nvim",
        url = "https://github.com/akinsho/bufferline.nvim",
        dependencies = {
            "nvim-web-devicons",
        },
        config = config,
    })
    manager:lazyload_event("BufWinEnter", "bufferline.nvim")
end
