local function config()
    local wk = require("which-key")
    wk.setup()
    wk.add({
        {
            "<Leader>p",
            group = "Picker",
        },
        {
            "<Leader>e",
            group = "Editor",
        },
        {
            "<Leader>c",
            group = "Code",
        },
        {
            "<Leader>o",
            group = "Overseer",
        },
    })
end

return function(manager)
    manager:add({
        id = "which-key.nvim",
        url = "https://github.com/folke/which-key.nvim",
        config = config,
    })
    manager:locked_load("which-key.nvim")
end
