local function config()
    require("markview").setup()
end

return function(manager)
    manager.add({
        id = "markview.nvim",
        url = "https://github.com/OXY2DEV/markview.nvim",
        config = config,
    })
    manager.load("markview.nvim")
end
