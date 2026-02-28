local function config(manager)
    require("manager.command").setup(manager)
end

return function(manager)
    manager:add({
        id = "manager-command",
        url = "https://github.com/shizukani-cp/manager-command",
        config = function()
            config(manager)
        end,
        dev = false,
        dir = require("utils.local_plugin_path")("manager-command"),
    })
    manager:lazyload_event("CmdLineEnter", "manager-command")
    --[[ vim.api.nvim_create_autocmd("CmdlineEnter", {
        group = vim.api.nvim_create_augroup("manager-command_load", { clear = true }),
        pattern = "*",
        callback = function()
            vim.opt.runtimepath:prepend(vim.fn.expand("$HOME") .. "/programs/manager-command")
        end
    }) ]]
end
