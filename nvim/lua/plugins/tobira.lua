local function config()
    require("tobira").setup({
        lang = "ja",
    })
end

return function(manager)
    manager:add({
        id = "tobira.nvim",
        url = "https://github.com/kamegoro/tobira.nvim",
        config = config,
    })
    manager:lazyload_event("SafeState", "tobira.nvim")
end
