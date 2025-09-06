local manager = require("utils.manager")

manager.add({
    id = "lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-web-devicons",
    },
    config = function()
        require("lualine").setup({
            options = {
                theme = "tokyonight",
                disabled_filetypes = {
                    winbar = {
                        "dap-repl",
                    },
                },
            },
            sections = {
                lualine_a = {
                    'mode',
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
                    }
                },
                lualine_b = {
                    'branch',
                    {
                        'diff',
                        symbols = {added = ' ', modified = ' ', removed = ' '},
                    },
                },
                lualine_c = {
                    {
                        'diagnostics',
                        symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}
                    },
                },
                lualine_x = {'encoding'},
                lualine_y = {
                    'filetype',
                    { 'filename', path=1 }
                },
                lualine_z = {'location'}
            },
        })
    end
})
manager.load("lualine.nvim")
