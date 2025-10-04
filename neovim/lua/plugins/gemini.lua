local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "gemini.nvim",
    url = "https://github.com/shizukani-cp/gemini.nvim",
    config = function()
        require("gemini").setup({
            default_bindings = false
        })
    end
})
lazyload.key("n", "<Leader>G", "<Cmd>GeminiOpen<Cr>", "gemini.nvim",
    { noremap = true, silent = true, desc = "Open Gemini CLI" })
