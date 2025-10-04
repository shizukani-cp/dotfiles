local manager = require("utils.manager")
local lazyload = require("utils.lazyload")

manager.add({
    id = "nvim_context_vt",
    url = "https://github.com/andersevenrud/nvim_context_vt",
    config = function()
        require("nvim_context_vt").setup()
    end
})
lazyload.key("n", "<Leader>v", "<Cmd>NvimContextVtToggle<Cr>", "nvim_context_vt",
    { noremap = true, silent = true, desc = "Toggle context virtual text" })
