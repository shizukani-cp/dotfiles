local function config()
    require("dropbar").setup()
    vim.ui.select = require("dropbar.utils.menu").select
end

return function(manager)
    manager:add({
        id = "dropbar.nvim",
        url = "https://github.com/Bekaboo/dropbar.nvim",
        dependencies = {
            "nvim-web-devicons",
            "nvim-treesitter",
        },
        config = config,
    })
    manager:lazyload_event("SafeState", "dropbar.nvim")
end
