local function config()
    require("neoscroll").setup()
end

return function(manager)
    manager:add({
        id = "neoscroll.nvim",
        url = "https://github.com/karb94/neoscroll.nvim",
        config = config,
    })
    manager:lazyload_event("BufWinEnter", "neoscroll.nvim")
end
