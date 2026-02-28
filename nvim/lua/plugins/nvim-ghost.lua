return function(manager)
    manager:add({
        id = "nvim-ghost",
        url = "https://github.com/subnut/nvim-ghost.nvim",
    })
    manager:lazyload_event("BufWinEnter", "nvim-ghost")
end
