local lazyload = require("manager.lazyload")

local function config()
    require("manager.command").setup()
end

return function(manager)
    manager.add({
        id = "manager-command",
        url = "https://github.com/shizukani-cp/manager-command",
        config = config,
    })
    lazyload.event("CmdLineEnter", "manager-command")
    --[[ vim.api.nvim_create_autocmd("CmdlineEnter", {
        group = vim.api.nvim_create_augroup("manager-command_load", { clear = true }),
        pattern = "*",
        callback = function()
            vim.opt.runtimepath:prepend(vim.fn.expand("$HOME") .. "/programs/manager-command")
        end
    }) ]]
end
