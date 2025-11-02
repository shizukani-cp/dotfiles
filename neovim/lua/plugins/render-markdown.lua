local lazyload = require("utils.lazyload")

local function config()
    require("render-markdown").setup()
end

return function(manager)
    manager.add({
        id = "render-markdown.nvim",
        url = "https://github.com/MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter",
            "nvim-web-devicons",
        },
        config = config
    })
    lazyload.event({ "BufReadPre", "BufNewFile", "FileType" }, "render-markdown.nvim",
        { "*.md", "*.markdown", "*.norg", "*.rmd", "*.org" })
end
