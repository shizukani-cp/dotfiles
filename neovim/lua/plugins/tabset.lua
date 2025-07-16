return {
    "FotiadisM/tabset.nvim",
    opts = {
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
    },
}
