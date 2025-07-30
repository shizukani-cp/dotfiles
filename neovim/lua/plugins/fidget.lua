local manager = require("utils.manager")

manager.add({
    id = "fidget.nvim",
    url = "https://github.com/j-hui/fidget.nvim",
    config = function ()
        require("fidget").setup()
    end
})
vim.api.nvim_create_autocmd("LspAttach", {
    group = lspattach_plugin_grp,
    pattern = "*",
    callback = function ()
        manager.load("fidget.nvim")
    end
})
