local function config()
    vim.fn["mkdp#util#install"]()
    vim.g.mkdp_filetypes = { "markdown" }
end

return function(manager)
    manager:add({
        id = "markdown-preview.nvim",
        url = "https://github.com/iamcco/markdown-preview.nvim",
        config = config,
    })

    manager:lazyload_filetype("markdown", "markdown-preview.nvim")
end
