local function config()
    require("overseer").setup()
end

return function(manager)
    manager:add({
        id = "overseer.nvim",
        url = "https://github.com/stevearc/overseer.nvim",
        config = config,
    })
    manager:lazyload_key(
        "n",
        "<Leader>or",
        "<Cmd>OverseerRun<Cr>",
        "overseer.nvim",
        { noremap = true, silent = true, desc = "Overseer run" }
    )
    manager:lazyload_key(
        "n",
        "<Leader>ot",
        "<Cmd>OverseerToggle<Cr>",
        "overseer.nvim",
        { noremap = true, silent = true, desc = "Overseer toggle" }
    )
end
