local function config()
    require("notify").setup()
end

return function(manager)
    manager.add({
        id = "nvim-notify",
        url = "https://github.com/rcarriga/nvim-notify",
        config = config,
    })
    manager.load("nvim-notify")
end
