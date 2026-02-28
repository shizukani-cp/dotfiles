local function config()
    require("fidget").setup()
end

return function(manager)
    manager:add({
        id = "fidget.nvim",
        url = "https://github.com/j-hui/fidget.nvim",
        config = config,
    })
    manager:lazyload_event("LspAttach", "fidget.nvim")
end
