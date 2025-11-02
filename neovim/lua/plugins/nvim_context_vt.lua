local lazyload = require("utils.lazyload")

local function config()
    require("nvim_context_vt").setup()
end

return function(manager)
    manager.add({
        id = "nvim_context_vt",
        url = "https://github.com/andersevenrud/nvim_context_vt",
        config = config
    })
    lazyload.key("n", "<Leader>cv", "<Cmd>NvimContextVtToggle<Cr>", "nvim_context_vt",
        { noremap = true, silent = true, desc = "Context virtual text" })
end
