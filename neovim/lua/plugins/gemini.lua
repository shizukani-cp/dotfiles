local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

manager.add({
    id = "gemini.nvim",
    url = "https://github.com/shizukani-cp/gemini.nvim",
    config = function ()
        require("gemini").setup({
            default_bindings = false
        })
    end
})
set_keymap("n", "<Space>G", "<Cmd>GeminiOpen<Cr>", "gemini.nvim", { noremap = true, silent = true, desc = "Open Gemini CLI" })
