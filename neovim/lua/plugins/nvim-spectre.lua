return {
    "nvim-pack/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "echasnovski/mini.icons",
    },
    keys = {
        {
            "<space>S",
            function ()
                require("spectre").toggle()
            end,
            mode = { "n", },
            desc = "Toggle spectre",
        },
    },
}
