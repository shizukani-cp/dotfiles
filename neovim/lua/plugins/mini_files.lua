return {
    'echasnovski/mini.files',
    version = false,
    keys = {
        {
            "<Space>f",
            function ()
                require("mini.files").open()
            end,
            mode = { "n", },
            silent = true,
            desc = "File tree",
        },
    },
}
