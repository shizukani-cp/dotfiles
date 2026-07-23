local function config()
    require("nvim-autopairs").setup()
end

return function(manager)
    manager:add({
        id = "nvim-autopairs",
        url = "https://github.com/windwp/nvim-autopairs",
        config = config,
    })
    manager:lazyload_event("InsertEnter", "nvim-autopairs")
end
