local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

vim.g.translator_target_lang = "ja"

manager.add({
    id = "vim-translator",
    url = "https://github.com/voldikss/vim-translator",
})
set_keymap("n", "<Space>T", "<Plug>TranslateW", "vim-translator", { noremap = true, silent = true, desc = "Open Translate Window" })
