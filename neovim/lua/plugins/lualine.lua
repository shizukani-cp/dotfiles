return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            theme = "onedark",
            disabled_filetypes = {
                winbar = {
                    "dap-repl",
                },
            },
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch'},
            lualine_c = {
                {
                    'diff',
                    symbols = {added = ' ', modified = ' ', removed = ' '},
                },
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
    }
}
