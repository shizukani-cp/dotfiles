local manager = require("utils.manager")

manager.add({
    id = "cmdline-hl.nvim",
    url = "https://github.com/Sam-programs/cmdline-hl.nvim",
    config = function ()
        require("cmdline-hl").setup()
    end
})
vim.api.nvim_create_autocmd("CmdlineEnter", {
    group = vim.api.nvim_create_augroup("cmdline-hl.nvim_load", { clear = true }),
    pattern = "*",
    callback = function ()
        manager.load("cmdline-hl.nvim")
    end
})
