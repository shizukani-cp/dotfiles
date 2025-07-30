local manager = require("utils.manager")

manager.add({
    id = "tabset.nvim",
    url = "https://github.com/FotiadisM/tabset.nvim",
    config = function ()
        require("tabset").setup({
            default = {
                tabwidth = 4,
                expandtab = true,
            },
            languages = {
                {
                    filetypes = { "javascript", "typescript", "html", "css", "json", },
                    config = {
                        tabwidth = 2,
                    },
                },
            },
        })
    end
})
manager.load("tabset.nvim")
