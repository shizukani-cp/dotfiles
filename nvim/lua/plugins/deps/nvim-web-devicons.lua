local function config()
    require("nvim-web-devicons").setup()
end

return function(manager)
    manager.add({
        id = "nvim-web-devicons",
        url = "https://github.com/nvim-tree/nvim-web-devicons",
        config = config,
    })
end
