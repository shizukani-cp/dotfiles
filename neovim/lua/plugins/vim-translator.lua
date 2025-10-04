local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

vim.g.translator_target_lang = "ja"

manager.add({
    id = "vim-translator",
    url = "https://github.com/voldikss/vim-translator",
})
lazyload.key("n", "<Space>T", "<Plug>TranslateW", "vim-translator", { noremap = true, silent = true, desc = "Open Translate Window" })
