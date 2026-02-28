local function config()
    require("toggleterm").setup({
        open_mapping = [[<C-_>]],
        hide_numbers = true,
        close_on_exit = true,
        direction = "tab",
    })
end

return function(manager)
    manager:add({
        id = "toggleterm.nvim",
        url = "https://github.com/akinsho/toggleterm.nvim",
        config = config,
    })
    manager:lazyload_event("BufWinEnter", "toggleterm.nvim")
end
