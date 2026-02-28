local function config()
    require("renamer").setup()
end

return function(manager)
    manager:add({
        id = "renamer.nvim",
        url = "https://github.com/filipdutescu/renamer.nvim",
        dependencies = {
            "plenary.nvim",
        },
        config = config,
    })

    manager:lazyload_key(
        "n",
        "<Leader>cr",
        "<Cmd>lua require('renamer').rename()<Cr>",
        "renamer.nvim",
        { noremap = true, silent = true, desc = "Rename symbol" }
    )
    manager:lazyload_key(
        "v",
        "<Leader>r",
        "<Cmd>lua require('renamer').rename()<Cr>",
        "renamer.nvim",
        { noremap = true, silent = true, desc = "Rename symbol" }
    )
end
