local manager = require("utils.manager")
local set_keymap = require("utils.set_keymap").set_keymap

manager.add({
    id = "nvim_context_vt",
    url = "https://github.com/andersevenrud/nvim_context_vt",
    config = function()
        require("nvim_context_vt").setup()
    end
})
set_keymap("n", "<Space>v", "<Cmd>NvimContextVtToggle<Cr>", "nvim_context_vt",
    { noremap = true, silent = true, desc = "Toggle context virtual text" })
