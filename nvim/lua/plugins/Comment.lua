local function config()
    require("Comment").setup({
        toggler = {
            line = "<Leader>cc",
            block = "<Leader>cC",
        },
        opleader = {
            line = "gcc",
            block = "gcC",
        },
    })
end

return function(manager)
    manager:add({
        id = "Comment.nvim",
        url = "https://github.com/numToStr/Comment.nvim",
        config = config,
    })
    manager:lazyload_event("BufWinEnter", "Comment.nvim")
end
