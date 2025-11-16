local lazyload = require("manager.lazyload")

local function config()
    require("pantran").setup({
        default_engine = "google",
        engines = {
            google = {}
        },
        ui = {
            width_percentage = 0.8,
            height_percentage = 0.8,
        },
        window = {
            title_border = { "⭐️ ", " ⭐️    " },
            window_config = { border = "rounded" },
        },
        controls = {
            mappings = {
                edit = {
                    n = {
                        ["S"] = require("pantran.ui.actions").switch_languages,
                        ["e"] = require("pantran.ui.actions").select_engine,
                        ["s"] = require("pantran.ui.actions").select_source,
                        ["t"] = require("pantran.ui.actions").select_target,
                        ["<C-y>"] = require("pantran.ui.actions").yank_close_translation,
                        ["g?"] = require("pantran.ui.actions").help,
                        ["<C-Q>"] = false,
                        ["gA"] = false,
                        ["gS"] = false,
                        ["gR"] = false,
                        ["ga"] = false,
                        ["ge"] = false,
                        ["gr"] = false,
                        ["gs"] = false,
                        ["gt"] = false,
                        ["gY"] = false,
                        ["gy"] = false,
                    },
                    i = {
                        ["<C-S>"] = require("pantran.ui.actions").switch_languages,
                        ["<C-e>"] = require("pantran.ui.actions").select_engine,
                        ["<C-s>"] = require("pantran.ui.actions").select_source,
                        ["<C-t>"] = require("pantran.ui.actions").select_target,
                        ["<C-y>"] = require("pantran.ui.actions").yank_close_translation,
                    },
                },
                select = {},
            },
        },
    })
end

return function(manager)
    manager.add({
        id = "pantran.nvim",
        url = "https://github.com/potamides/pantran.nvim",
        config = config
    })

    lazyload.key("n", "<Leader>et", "<Cmd>Pantran<Cr>", "pantran.nvim",
        { noremap = true, silent = true, desc = "Translate Window" })
    --[[ lazyload.key("x", "<Leader>t", function() require("pantran").range_translate({}) end, "pantran.nvim",
    { noremap = true, silent = true, desc = "Open Translate Window" }) ]]
end
