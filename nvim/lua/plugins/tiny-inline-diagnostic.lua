local lazyload = require("manager.lazyload")

local function config()
    require("tiny-inline-diagnostic").setup({
        options = {
            add_messages = {
                display_count = true,
            },
            multilines = {
                enabled = true,
            },
            show_source = {
                enabled = true,
            },
        },
    })
    vim.diagnostic.config({ virtual_text = false })
end

return function(manager)
    manager.add({
        id = "tiny-inline-diagnostic.nvim",
        url = "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
        config = config,
    })
    lazyload.event("LspAttach", "tiny-inline-diagnostic.nvim")
end
