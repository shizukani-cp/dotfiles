local function config()
    require("smartcolumn").setup()
end

return function(manager)
    manager:add({
        id = "smart-column.nvim",
        url = "https://github.com/m4xshen/smartcolumn.nvim",
        config = config,
    })
    manager:lazyload_event("SafeState", "smart-column.nvim")
end
