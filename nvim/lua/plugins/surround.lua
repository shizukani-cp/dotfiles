local function config()
    require("nvim-surround").setup()
end

return function(manager)
    manager:add({
        id = "nvim-surround",
        url = "https://github.com/kylechui/nvim-surround",
        config = config,
    })

    manager:lazyload_event("SafeState", "nvim-surround")
end
