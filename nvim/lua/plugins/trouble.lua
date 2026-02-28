local function config()
    require("trouble").setup()
end

return function(manager)
    manager:add({
        id = "trouble.nvim",
        url = "https://github.com/folke/trouble.nvim",
        config = config,
    })
    manager:lazyload_key(
        "n",
        "<Leader>cd",
        "<Cmd>Trouble diagnostics toggle<Cr>",
        "trouble.nvim",
        { noremap = true, silent = true, desc = "Diagnostics" }
    )
end
