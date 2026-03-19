return function(manager)
    manager:add({
        id = "mkdir.nvim",
        url = "https://github.com/jghauser/mkdir.nvim",
    })
    manager:locked_load("mkdir.nvim")
end
