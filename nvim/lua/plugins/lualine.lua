local function config()
    require("lualine").setup({
        options = {
            theme = "onedark",
        },
        sections = {
            lualine_a = {
                "mode",
                {
                    function()
                        local _, mode = pcall(vim.fn["skkeleton#mode"])
                        if mode == "hira" then
                            return "全ひ"
                        elseif mode == "kata" then
                            return "全カ"
                        elseif mode == "hankata" then
                            return "半ｶﾀ"
                        elseif mode == "zenkaku" then
                            return "全Ａ"
                        elseif mode == "abbrev" then
                            return "abbr"
                        else
                            return "英ab"
                        end
                    end,
                },
            },
            lualine_b = {
                "branch",
                {
                    "diff",
                    symbols = { added = " ", modified = " ", removed = " " },
                },
            },
            lualine_c = {
                "lsp-status",
                {
                    "diagnostics",
                    symbols = { error = " ", warn = " ", info = " ", hint = " " },
                },
            },
            lualine_x = {
                "overseer",
            },
            lualine_y = {
                "filesize",
                "encoding",
                "filetype",
            },
            lualine_z = {
                { "filename", path = 1 },
                "location",
            },
        },
    })
end

return function(manager)
    manager.add({
        id = "lualine.nvim",
        url = "https://github.com/nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-web-devicons",
            "lualine-lsp-status",
        },
        config = config,
    })
    manager.load("lualine.nvim")
end
