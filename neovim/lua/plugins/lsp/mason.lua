local function config()
    require("mason").setup()
end

return function(manager)
    manager.add({
        id = "mason.nvim",
        url = "https://github.com/mason-org/mason.nvim",
        config = config
    })
end
