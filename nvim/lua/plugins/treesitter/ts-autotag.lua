local function config()
    require("nvim-ts-autotag").setup()
end

return function(manager)
    manager:add({
        id = "nvim-ts-autotag",
        url = "https://github.com/windwp/nvim-ts-autotag",
        config = config,
    })

    manager:lazyload_event("SafeState", "nvim-ts-autotag")
end
