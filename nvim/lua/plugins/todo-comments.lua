local function config()
    require("todo-comments").setup()
end

return function(manager)
    manager:add({
        id = "todo-comments.nvim",
        url = "https://github.com/folke/todo-comments.nvim",
        dependencies = {
            "plenary.nvim",
        },
        config = config,
    })
    manager:lazyload_event("SafeState", "todo-comments.nvim")
end
