local M = {}

local manager = require("utils.manager")

function M.set_keymap(mode, lhs, rhs, plugin_id, opts)
    vim.keymap.set(
        mode, lhs,
        function ()
            manager.load(plugin_id)
            vim.keymap.set(mode, lhs, rhs, opts)
            if type(rhs) == "string" then
                local keys = vim.api.nvim_replace_termcodes(rhs, true, false, true)
                vim.api.nvim_feedkeys(keys, 'n', true)
            else
                rhs()
            end
        end,
        opts
    )
end

return M
