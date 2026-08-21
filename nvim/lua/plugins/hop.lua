local function config()
    require("hop").setup({ keys = "iouatnsrhkdcmpgwbzl" })
end

return function(manager)
    manager:add({
        id = "hop.vim",
        url = "https://github.com/smoka7/hop.nvim",
        config = config,
    })
    manager:lazyload_key(
        "n",
        "s",
        "<Cmd>HopWord<Cr>",
        "hop.vim",
        { noremap = true, silent = true, desc = "Go to any word in the current buffer." }
    )
end
