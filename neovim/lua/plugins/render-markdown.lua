local manager = require("utils.manager")

manager.add({
    id = "render-markdown.nvim",
    url = "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter",
        "nvim-web-devicons",
    },
    config = function ()
        require("render-markdown").setup()
    end
})
vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile", "FileType" }, {
    group = vim.api.nvim_create_augroup("render-markdown.nvim_load", { clear = true }),
    pattern = { "*.md", "*.markdown", "*.norg", "*.rmd", "*.org" },
    callback = function(event)
        manager.load("render-markdown.nvim")
    end,
})
