return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', },
    keys = {
        {
            "<Space>F",
            function ()
                require('telescope.builtin').find_files()
            end,
            mode = { "n", },
            silent = true,
        },
        {
            "<Space>b",
            function ()
                require('telescope.builtin').buffers()
            end,
            mode = { "n", },
            silent = true,
        },
        {
            "<Space>s",
            function ()
                require('telescope.builtin').lsp_document_symbols()
            end,
            mode = { "n", },
            silent = true,
        },
    },
}
