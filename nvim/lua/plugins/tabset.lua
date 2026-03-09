local function config()
    require("tabset").setup({
        default = {
            tabwidth = 4,
            expandtab = true,
        },
        languages = {
            {
                filetypes = {
                    "css",
                    "html",
                    "htmldjango",
                    "javascript",
                    "javascriptreact",
                    "json",
                    "nix",
                    "typescript",
                    "typescriptreact",
                },
                config = {
                    tabwidth = 2,
                },
            },
        },
    })
end

return function(manager)
    manager:add({
        id = "tabset.nvim",
        url = "https://github.com/FotiadisM/tabset.nvim",
        config = config,
    })
    manager:load("tabset.nvim")
end
