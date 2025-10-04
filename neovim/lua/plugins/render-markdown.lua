local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

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
lazyload.event({ "BufReadPre", "BufNewFile", "FileType" }, "render-markdown.nvim", { "*.md", "*.markdown", "*.norg", "*.rmd", "*.org" })
